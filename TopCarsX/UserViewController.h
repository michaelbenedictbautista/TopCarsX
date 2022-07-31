//
//  UserViewController.h
//  TopCarsX
//
//  Created by Mike on 31/7/2022.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property User * user;
@property (weak, nonatomic) IBOutlet UIScrollView *UserScrollView;

@property (strong, nonatomic) IBOutlet UITableView *UsersTableView;

@end

NS_ASSUME_NONNULL_END
