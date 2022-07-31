//
//  UserViewController.m
//  TopCarsX
//
//  Created by Mike on 31/7/2022.
//

#import "UserViewController.h"
#import "CarsTableViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Adjust the size of the scrollview
    _UserScrollView.contentSize = CGSizeMake(317, 950);

    _user = [[User  alloc] init];
    
        [[self user] setFirstName:@"Joe"];
        [[self user] setLastName: @"Smith"];
        [[self user] setEmail:@"Joe@gmail.com"];
        [[self user] setPassword: @"12345"];
        [[self user] setPhoto:[UIImage imageNamed:@"userPhoto"]];
    
    // Set hardcoded email and password
    [[self emailTextField] setText:[_user email]];
    [[self passwordTextField] setText:[_user password]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)loginButton:(id)sender {
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    if ([[segue destinationViewController] isKindOfClass:[ CarsTableViewController class]]) {
        CarsTableViewController* carsTableViewController = [segue destinationViewController ];
        [carsTableViewController setUser:_user];
       
    }
    
}

@end
