//
//  CarsTableViewController.m
//  TopCarsX
//
//  Created by Mike on 25/7/2022.
//

#import "CarsTableViewController.h"
#import "CarsTableViewCell.h"
#import "CarViewController.h"


@interface CarsTableViewController ()

@end

@implementation CarsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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
    
    // Configure the cell...
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end