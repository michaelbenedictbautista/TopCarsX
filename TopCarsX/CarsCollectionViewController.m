//
//  CarsCollectionViewController.m
//  TopCarsX
//
//  Created by Mike on 28/7/2022.
//

#import "CarsCollectionViewController.h"
#import "CarsCollectionViewCell.h"
#import "CarViewController.h"


@interface CarsCollectionViewController ()

@end

@implementation CarsCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    
    // Connect to firebase
    self.firestore = [FIRFirestore firestore];
    
    _carsDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    
    // Create instance of CarViewController to get the stored data
    CarViewController * carViewController = [[CarViewController alloc] init];
    [carViewController setFirestore:[self firestore]];
    
    
    // This will executed in separate thread
    [carViewController findAll:^(NSMutableDictionary * _Nonnull dictionary) {
        if (dictionary != nil) {
            for (NSString * key in dictionary) {
                [[self carsDictionary] setObject:[dictionary objectForKey:key] forKey:key];
            }
        
        }
        [[self carsCollectionView]reloadData];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Total number of cars found %li", [[self carsDictionary] count]);
    return [[self carsDictionary] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"CarCell";
    
    
    CarsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    
    
    // Configure the cell...
//    if (cell == nil) {
//        cell  = [[CarsCollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
//    if (cell == nil) {
//        cell = [CarsCollectionViewCell alloc] initWithCoder:UICollectionViewCell class
//    
//    
//    }
    NSString * carID = [[self carsDictionary] allKeys][[indexPath row] ];
    NSLog(@"carId: %@", carID);
    
    NSArray * carsArray = [[self carsDictionary] allValues];
    
    NSDictionary * carDictionary = [carsArray objectAtIndex:[indexPath row]];
    
    
    [[cell ratingLabel] setText:[carDictionary objectForKey:@"rating"]];
    [[cell makeLabel] setText:[carDictionary objectForKey:@"make"]];
    [[cell modelLabel]setText:[carDictionary objectForKey:@"model"]];
    [[cell photoImageView] setImage:[UIImage imageNamed:[carDictionary objectForKey:@"photo"]]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


@end
