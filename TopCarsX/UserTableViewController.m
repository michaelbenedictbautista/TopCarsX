//
//  UserTableViewController.m
//  TopCarsX
//
//  Created by Mike on 29/7/2022.
//

#import "UserTableViewController.h"
#import "CarsTableViewController.h"

@interface UserTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;



@end

@implementation UserTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //User * user = [[User alloc] init];
    
    _user = [[User  alloc] init];
    
    [[self user] setFirstName: @"Joe"];
    [[self user] setLastName: @"Smith"];
    [[self user] setEmail:@"Joe@gmail.com"];
    [[self user] setPassword: @"12345"];
    [[self user] setPhoto:[UIImage imageNamed:@"userPhoto"]];

}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//    
//    NSString * emailUserInput =  [[self emailTextField] text];
//    NSString * passwordUserInput =  [[self passwordTextField] text];
//    
//    UITableViewController* viewController = [segue destinationViewController];
//    
//    if ([viewController isKindOfClass:[CarsTableViewController class]] && _user.email == emailUserInput && _user.password == passwordUserInput) {
//        // The destination of segue is going to CarsTableViewController only
//        CarsTableViewController* carsTableViewController = [segue destinationViewController];
//        NSLog(@"Going to Homes Screen");
//        //[carsTableViewController setUser:[self user]];
//       
//    }
//    
//}


//- (IBAction)loginButton:(id)sender {
//    CarsTableViewController* carsTableViewController = [segue destinationViewController];
//
//    User * user = [[User alloc] init];
//    NSString * emailUserInput =  [[self emailTextField] text];
//    NSString * passwordUserInput =  [[self passwordTextField] text];
//
//    if ([user email] == emailUserInput && [user email] == passwordUserInput ) {
//
//
//    }
//}

@end
