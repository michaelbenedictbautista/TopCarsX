//
//  generateQRTableViewController.h
//  TopCarsX
//
//  Created by Mike on 8/8/2022.
//

#import <UIKit/UIKit.h>
#import "Car.h"
#import "CarDetailsTableViewController.h"
#import "CarViewController.h"
@import Firebase;
@import FirebaseDatabase;

NS_ASSUME_NONNULL_BEGIN

@interface generateQRTableViewController : UITableViewController

@property (strong, nonatomic) FIRFirestore *firestore;

@property Car * car;
@property CarDetailsTableViewController * caarDetailsTableViewController;



@end

NS_ASSUME_NONNULL_END
