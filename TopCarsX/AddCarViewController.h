//
//  AddCarViewController.h
//  TopCarsX
//
//  Created by Mike on 31/7/2022.
//

#import <UIKit/UIKit.h>
#import "Car.h"
@import Firebase;


NS_ASSUME_NONNULL_BEGIN

@interface AddCarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *makeTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;

@property (weak, nonatomic) IBOutlet UITextField *transmissionTextField;
@property (weak, nonatomic) IBOutlet UITextField *drivetrainTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *transmissionDrivetrainPicker;

@property (weak, nonatomic) IBOutlet UITextField *engineTextField;

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *photoPicker;

@property (weak, nonatomic) IBOutlet UITextField *videoTextField;

@property NSArray* photoArray;
@property NSArray* transmissionDrivetrain;

@property (nonatomic,strong) FIRFirestore * firestore;

@property (weak, nonatomic) IBOutlet UIScrollView *addScrollView;

@property Car * car;

-(BOOL) update: (Car*) car;
@end

NS_ASSUME_NONNULL_END
