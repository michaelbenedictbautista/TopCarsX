//
//  AddCarViewController.m
//  TopCarsX
//
//  Created by Mike on 31/7/2022.
//

#import "AddCarViewController.h"
#import "CarViewController.h"
#import "Car.h"

@interface AddCarViewController ()
@property CarViewController * carViewController;

@end

@implementation AddCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _addScrollView.contentSize = CGSizeMake(317, 2000);
    
    self.firestore = [FIRFirestore firestore];
    
    CarViewController * carViewController = [[CarViewController alloc] init];
    [ [self carViewController] setFirestore:[self firestore]];
    
    
    _transmissionDrivetrain = @[@[@"Auto", @"Manual", @"Auto&Manual"], @[@"All-wheel", @"Rear-wheel", @"Front-wheel"]];
    
//    _photoArray = @[@"defaultCar1", @"defaultCar2", @"defaultCar3"];
    
//    [[self photoPicker] setDelegate:self];
//    [[self photoPicker] setDataSource:self];
    [[self transmissionDrivetrainPicker] setDelegate:self];
    [[self transmissionDrivetrainPicker] setDataSource:self];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL) add: (Car *) car{
    __block BOOL isAdded = YES;
    @try {
        //Returns a FIRDocumentReference pointing to a new document with an auto-generated ID.
        FIRDocumentReference *carReference = [[[self firestore] collectionWithPath:@"SportsCars"] documentWithAutoID];
        //Do something with the new car and then, send it to the DB by calling setData
        
        [carReference setData:@{
            @"make": [car make],
            @"model": [car model],
            @"year": [car year],
            @"transmission": [car transmission],
            @"drivetrain": [car drivetrain],
            @"engine": [car engine],
            @"price": [car price],
            @"rating": [car rating],
            //@"photo": [car photo],
            //@"photo":[UIImage imageNamed:@"defaultCar1"],
            @"video": [car video]
        } completion:^(NSError * _Nullable error) {
            if(error != nil){
                NSLog(@"Error adding document: %@", error);
                isAdded = NO;
            }else {
                NSLog(@"all good...");
            }
        }];
    } @catch (NSException *exception) {
        isAdded = NO;
    }
    return isAdded;
}

// add car button
- (IBAction)didPressAddButton:(id)sender {
    Car * car = [[Car alloc] init];
    [car setMake:[[self makeTextField] text] ];
    [car setModel:[[self modelTextField] text] ];
    [car setYear:[[self yearTextField] text] ];
    [car setTransmission:[[self transmissionTextField] text] ];
    
    [car setDrivetrain:[[self drivetrainTextField] text] ];
    [car setEngine:[[self engineTextField] text] ];
    [car setPrice:[[self priceTextField] text] ];
    [car setRating:[[self ratingTextField] text] ];
    [car setVideo:[[self videoTextField] text] ];
    [car setPhoto:[UIImage imageNamed:@"defaultCar1"]];
    
    [self add:car];
}


// 1. This numberOfComponentsInPickerView function determine how many columns
-(NSInteger) numberOfComponentsInPickerView:(nonnull UIPickerView*) pickerView {
    return 2;
}

// 2. This numberOfRowsInComponent function determine how many rows
-(NSInteger) pickerView:(UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self transmissionDrivetrain][component]count];
}

// 3 This didSelectRow function determine the selected position
-(void) pickerView:(UIPickerView*) pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"You have selected:  %@", [self transmissionDrivetrain][component][row]);
    
    Car * car = [[Car alloc] init];
    [car setTransmission:[[self transmissionTextField] text] ];
    
    [car setDrivetrain:[[self drivetrainTextField] text] ];
    
    
    NSString* myTransmission = [self transmissionDrivetrain][0] [[pickerView selectedRowInComponent: 0] ];
        [[self transmissionTextField] setText:myTransmission];
    
    
    NSString* myDrivetrain = [self transmissionDrivetrain][1] [[pickerView selectedRowInComponent: 1] ];
        [[self drivetrainTextField] setText:myDrivetrain];
}


// 4. This titleForRow function display the selected title or value for selected position
-(NSString*) pickerView: (UIPickerView*) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //return [self states][component][row], [self states][component][row];
    
    return [self transmissionDrivetrain][component][row];
}

@end
