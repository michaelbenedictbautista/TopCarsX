//
//  CarsTableViewController.h
//  TopCarsX
//
//  Created by Mike on 25/7/2022.
//

#import <UIKit/UIKit.h>
#import "User.h"
@import Firebase;


NS_ASSUME_NONNULL_BEGIN

@interface CarsTableViewController : UITableViewController

@property (nonatomic,strong) FIRFirestore * firestore;
@property (strong, nonatomic) NSMutableDictionary *carsDictionary;
@property (strong, nonatomic) IBOutlet UITableView *carsTableView;
@property User * user;
@end

NS_ASSUME_NONNULL_END
