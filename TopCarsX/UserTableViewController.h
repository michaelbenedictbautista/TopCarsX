//
//  UserTableViewController.h
//  TopCarsX
//
//  Created by Mike on 29/7/2022.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *UsersTableView;

@property User* user;

@end

NS_ASSUME_NONNULL_END
