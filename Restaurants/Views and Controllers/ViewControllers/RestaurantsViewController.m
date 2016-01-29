//
//  RestaurantsViewController.m
//  Restaurants
//
//  Created by Landron, Emil on 1/27/16.
//  Copyright © 2016 Emil Landron. All rights reserved.
//

#import "ImageSource.h"
#import "LoadRestaurantsOperation.h"
#import "ProgressNavigationBar.h"
#import "Restaurant.h"
#import "RestaurantCell.h"
#import "RestaurantDetailsViewController.h"
#import "RestaurantsMapViewController.h"
#import "RestaurantsViewController.h"

@interface RestaurantsViewController () < UICollectionViewDelegateFlowLayout, ImageSourceDelegate>

@property (nonatomic, weak) LoadRestaurantsOperation *loadRestaurantOperation;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSArray<Restaurant *> *restaurants;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ImageSource *imageSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mapButtonItem;

@end

@implementation RestaurantsViewController

static NSString *const kMapSegueIdentifier = @"RestaurantsMap";
static NSString *const kRestaurantDetailsSegueIdentifier = @"RestaurantDetails";
static NSString *const kReuseIdentifier = @"Cell";
static NSInteger const kNumberOfColumnsForCompactHorizontalSizeClass = 1;
static NSInteger const kNumberOfColumnsForRegularHorizontalSizeClass = 2;
static CGFloat const kDefaultCellHeight = 180;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.operationQueue = [[NSOperationQueue alloc] init];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(didPullToRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];

    self.imageSource = [[ImageSource alloc] initWithDefaultImage:[[UIImage alloc]init]];
    self.imageSource.delegate = self;
    [self validateMapButtonState];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (!self.restaurants && !self.loadRestaurantOperation)
    {
        [self loadRestaurants:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.loadRestaurantOperation cancel];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition: ^(id < UIViewControllerTransitionCoordinatorContext >  _Nonnull context){
         [weakSelf.collectionView.collectionViewLayout invalidateLayout];
     } completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kMapSegueIdentifier])
    {
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        RestaurantsMapViewController *mapController = (RestaurantsMapViewController *)navigationController.topViewController;
        mapController.restaurants = self.restaurants;
        mapController.operationQueue = self.operationQueue;
    }
    else if ([segue.identifier isEqualToString:kRestaurantDetailsSegueIdentifier])
    {
        NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems].firstObject;

        NSAssert(indexPath, @"Restaurant does not have a selected cell while executing details segue. This should never happen");

        Restaurant *restaurant = self.restaurants[indexPath.row];
        RestaurantDetailsViewController *detailsController = (RestaurantDetailsViewController *)segue.destinationViewController;
        detailsController.restaurant = restaurant;
    }
}

- (IBAction)restaurantsUnwindSegue:(UIStoryboardSegue *)segue
{
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.restaurants.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Restaurant *restaurant = self.restaurants[indexPath.row];
    RestaurantCell *cell = (RestaurantCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];

    cell.titleLabel.text = restaurant.name;
    cell.categoryLabel.text = restaurant.category;
    cell.imageView.image = [self.imageSource imageForIndexPath:indexPath];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    Restaurant *restaurant = self.restaurants[indexPath.row];

    [self.imageSource willDisplayImageWithURL:restaurant.backgroundImageURL atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageSource didEndDisplayingImageAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL compact = (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact);
    CGFloat columns = compact ? kNumberOfColumnsForCompactHorizontalSizeClass : kNumberOfColumnsForRegularHorizontalSizeClass;

    return CGSizeMake(self.collectionView.bounds.size.width / columns, kDefaultCellHeight);
}

#pragma mark - Image Source Delegate

- (void)imageSource:(ImageSource *)imageSource didLoadImageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - Target Action

- (void)didPullToRefresh:(UIRefreshControl *)sender
{
    [self loadRestaurants:YES];
}

#pragma mark - Helpers

- (void)validateMapButtonState
{
    self.mapButtonItem.enabled = self.restaurants != nil;
}

- (void)loadRestaurants:(BOOL)userInitiated
{
    [self.loadRestaurantOperation cancel];

    __weak typeof(self) weakSelf = self;

    [self.refreshControl beginRefreshing];

    LoadRestaurantsOperation *loadRestaurantsOperation = [[LoadRestaurantsOperation alloc] init];
    loadRestaurantsOperation.completionHandlerQueue = dispatch_get_main_queue();
    loadRestaurantsOperation.userInitiated = userInitiated;

    loadRestaurantsOperation.progressHandler = ^(NetworkOperation *operation, CGFloat progress){
        ProgressNavigationBar *navBar = (ProgressNavigationBar *)weakSelf.navigationController.navigationBar;
        navBar.progress = progress;
    };

    loadRestaurantsOperation.completionHandler = ^(ConcurrentOperation *operation, NSArray<NSError *> *errors){
        if (errors.count > 0)
        {
            // TODO: Alert
        }
        else
        {
            LoadRestaurantsOperation *loadRestaurants = (LoadRestaurantsOperation *)operation;
            weakSelf.restaurants = loadRestaurants.entities;
            [weakSelf.imageSource clearAllImages];
            [weakSelf.collectionView reloadData];
            [weakSelf validateMapButtonState];
        }

        [weakSelf.refreshControl endRefreshing];
    };

    self.loadRestaurantOperation = loadRestaurantsOperation;
    [self.operationQueue addOperation:loadRestaurantsOperation];
}

@end