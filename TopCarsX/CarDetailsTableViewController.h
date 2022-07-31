//
//  CarDetailsTableViewController.h
//  TopCarsX
//
//  Created by Mike on 30/7/2022.
//

#import <UIKit/UIKit.h>
#import "Car.h"
#import "CarViewController.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface CarDetailsTableViewController : UITableViewController

@property (nonatomic, strong) FIRFirestore *firestore;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *makeLabel;
@property (weak, nonatomic) IBOutlet UITextField *modelLabel;
@property (weak, nonatomic) IBOutlet UITextField *yearLabel;

@property (weak, nonatomic) IBOutlet UITextField *transimissionTextField;
@property (weak, nonatomic) IBOutlet UITextField *drivetrainTextField;
@property (weak, nonatomic) IBOutlet UITextField *engineTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;



@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;


@property Car * car;

-(BOOL) update: (Car*) car;
-(BOOL) delete: (Car*) car;

-(void) textFieldDEnabled;
-(void) textFieldDisabled;

@end

NS_ASSUME_NONNULL_END
