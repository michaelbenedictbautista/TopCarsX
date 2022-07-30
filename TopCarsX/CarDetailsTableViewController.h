//
//  CarDetailsTableViewController.h
//  TopCarsX
//
//  Created by Mike on 30/7/2022.
//

#import <UIKit/UIKit.h>
#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarDetailsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *transimissionTextField;
@property (weak, nonatomic) IBOutlet UITextField *drivetrainTextField;
@property (weak, nonatomic) IBOutlet UITextField *engineTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;



@property Car * car;

@end

NS_ASSUME_NONNULL_END
