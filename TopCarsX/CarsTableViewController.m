//
//  CarsTableViewController.m
//  TopCarsX
//
//  Created by Mike on 25/7/2022.
//

#import "CarsTableViewController.h"
#import "CarsTableViewCell.h"
#import "CarViewController.h"
#import "UserViewController.h"
#import "CarDetailsTableViewController.h"
#import "CarVideoTableViewController.h"
#import "AddCarViewController.h"


@interface CarsTableViewController ()
@property Car * selectedCar;
@end

@implementation CarsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.firestore = [FIRFirestore firestore];
    
    _carsDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    
    // Create instance of CarViewController to get the stored data
    CarViewController * carViewController = [[CarViewController alloc] init];
    [carViewController setFirestore:[self firestore]];
    
    
    // This will be executed in separate thread
    [carViewController findAll:^(NSMutableDictionary * _Nonnull dictionary) {
        if (dictionary != nil) {
            for (NSString * key in dictionary) {
                [[self carsDictionary] setObject:[dictionary objectForKey:key] forKey:key];
            }
        
        }
        [[self carsTableView]reloadData];
    }];
        
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Total number of cars found %li", [[self carsDictionary] count]);
    return [[self carsDictionary] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"CarCell";
    
    CarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cells
    if (cell == nil) {
        cell  = [[CarsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString * carID = [[self carsDictionary] allKeys][[indexPath row] ];
    NSLog(@"carId: %@", carID);
    
    NSArray * carsArray = [[self carsDictionary] allValues];
    
    NSDictionary * carDictionary = [carsArray objectAtIndex:[indexPath row]];
    

    [[cell makeLabel] setText:[carDictionary objectForKey:@"make"]];
    [[cell modelLabel]setText:[carDictionary objectForKey:@"model"]];
    [[cell photoImageView] setImage:[UIImage imageNamed:[carDictionary objectForKey:@"photo"]]];
    
    return cell;
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Select position all keys(autoId) and assign to selected car variable
    NSInteger selectedRow = [indexPath row];
    NSString* key = [[self carsDictionary] allKeys] [selectedRow];
    NSMutableDictionary * selectedCarDictionary = [[self carsDictionary] objectForKey:key];
    _selectedCar = [[Car alloc] initWithDictionary:selectedCarDictionary];
    
    NSLog(@"This is the selected car %@", [self selectedCar]);
    
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue destinationViewController] isKindOfClass:[ CarDetailsTableViewController class]]) {
        CarDetailsTableViewController* carDetailsTableViewController = [segue destinationViewController ];
        [carDetailsTableViewController setCar:[self selectedCar]];
        
    } 
}

// unwind or to avoid going back to AddCarViewController
- (IBAction)unwindToAddCarViewController:(UIStoryboardSegue *)unwindSegue {
    UIViewController *sourceViewController = unwindSegue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[ AddCarViewController class]]) {
        NSLog(@"We can't go back to Add screen due to implemeneted unwind segue.");
        
    } 
}

- (IBAction)unwindToCarDetailsTableViewController:(UIStoryboardSegue *)unwindSegue {
    UIViewController *sourceViewController = unwindSegue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[ CarDetailsTableViewController class]]) {
        NSLog(@"We can't go back to Login screen due to implemeneted unwind segue.");
        
    }
}


@end
