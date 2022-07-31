//
//  CarViewController.m
//  TopCarsX
//
//  Created by Mike on 11/7/2022.
//

#import "CarViewController.h"
#import "Car.h"

@interface CarViewController ()
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *makeTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *transmissionTextField;
@property (weak, nonatomic) IBOutlet UITextField *drivetrainTextField;
@property (weak, nonatomic) IBOutlet UITextField *engineTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
//@property (weak, nonatomic) IBOutlet UITextField *photoTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *videoTextField;



@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _carScrollViewController.contentSize = CGSizeMake(317, 950);
    
    _carsDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    //CarViewController * carViewController = [[CarViewController alloc] init];
    
    // This will executed in separate thread
    [self findAll:^(NSMutableDictionary * _Nonnull dictionary) {
        if (dictionary != nil) {
            for (NSString * key in dictionary) {
                [[self carsDictionary] setObject:[dictionary objectForKey:key] forKey:key];
            }
        
        }
        //[[self carViewController]reloadData];
    }];
    
    _carNSDictionary = [[NSDictionary alloc] init];
    
    // connect to firebase
    self.firestore = [FIRFirestore firestore];
    
    FIRCollectionReference *carsCollectionRef = [[self firestore] collectionWithPath: @"SportsCars"];
    
    FIRQuery *query = [carsCollectionRef queryWhereField:@"make" isEqualTo:@"BMW"];
    
    
    // validate firebase connection
    [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error connection occured: %@", error);
        } else {
            //we received data from firebase
            for ( FIRDocumentSnapshot * document in [snapshot documents]) {
                NSLog(@"DocumentID: %@", [document documentID]);
                NSDictionary *myCars =  [document data];
                NSLog(@"Cars %@", myCars);
            }
            
        }
    }];
}

// validation of every field
-(BOOL) carPassedValidations: (Car*) car
                           error: (NSMutableArray*) validationFailedMessages {
    
    BOOL passed = YES;
    /** Validate CarMake */
    //remove empty spaces at the beginning and end
    NSString* trimmedCarMake = [[car make] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarMake length] == 0){
        [validationFailedMessages addObject:@"Car make is mandatory"];
        passed = NO;
    }
    
    /** Validate CarModel */
    NSString* trimmedCarModel = [[car model] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([trimmedCarModel length] == 0){
        [validationFailedMessages addObject:@"Model is mandatory"];
        passed = NO;
    }
    
    /** Validate CarYear */
    NSString* trimmedCarYear = [[car year] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarYear length] == 0){
        [validationFailedMessages addObject:@"Year is mandatory"];
        passed = NO;
    }
    
    /** Validate CarTransmission */
    NSString* trimmedCarTransmission = [[car transmission] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarTransmission length] == 0){
        [validationFailedMessages addObject:@"Transmission is mandatory"];
        passed = NO;
    }
    
//    /** Validate CarDrivetrain */
//    NSString* trimmedCarDrivetrain = [[car drivetrain] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //check if there is something to search for after removing the empty spaces
//    if([trimmedCarDrivetrain length] == 0){
//        [validationFailedMessages addObject:@"Drivetrain is mandatory"];
//        passed = NO;
//    }
    
    /** Validate CarEngine */
    NSString* trimmedCarEngine = [[car engine] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarEngine length] == 0){
        [validationFailedMessages addObject:@"Engine is mandatory"];
        passed = NO;
    }
    
    /** Validate CarPrice */
    NSString* trimmedCarPrice = [[car price] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarPrice length] == 0){
        [validationFailedMessages addObject:@"Price is mandatory"];
        passed = NO;
    }
    
    /** Validate CarRating*/
    NSString* trimmedCarRating = [[car rating] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarRating length] == 0){
        [validationFailedMessages addObject:@"Rating is mandatory"];
        passed = NO;
    }
    
//    /** Validate CarPhoto*/
//    NSString* trimmedCarPhoto = [[car photo] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //check if there is something to search for after removing the empty spaces
//    if([trimmedCarPhoto length] == 0){
//        [validationFailedMessages addObject:@"Photo is mandatory"];
//        passed = NO;
//    }
    
    /** Validate CarVideo*/
    NSString* trimmedCarVideo = [[car video] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarVideo length] == 0){
        [validationFailedMessages addObject:@"Video is mandatory"];
        passed = NO;
    }
    
    return passed;
}

//UI alery message function declaration and definition
-(void) showUIAlertWithMessage:(NSString*) message andTitle:(NSString*)title{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
    
        [self presentViewController:alert animated:YES completion:^{
            NSLog(@"%@", message);
        }];
}

//Clear textfields function declaration and definition
-(void) clearScreen {
    [[self idTextField] setText:@""];
    [[self makeTextField] setText:@""];
    [[self modelTextField] setText:@""];
    [[self yearTextField] setText:@""];
    [[self transmissionTextField] setText:@""];
    [[self drivetrainTextField] setText:@""];
    [[self engineTextField] setText:@""];
    [[self priceTextField] setText:@""];
    [[self ratingTextField] setText:@""];
    //[[self photoTextField] setText:@""];
    [[self photoImageView] setImage:[UIImage imageNamed:@"carDefault"]];
    [[self videoTextField] setText:@""];
    
}
//Clear Button action
- (IBAction)didPressClear:(id)sender {
    [self clearScreen]; // call clearScreen function when once Clear button is clicked.
}


//Search by ID function declaration and definition
-(void) searchCarById: (NSString *) carId completeBlock: (void(^)(Car *)) completeBlock {
    
    __block Car * carFound;
    
    // This is method to find specific autoId in a collection with document
    FIRDocumentReference * carsCollectionRef = [[[self firestore] collectionWithPath:@"SportsCars"] documentWithPath:carId];
    
    [carsCollectionRef getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if ([snapshot exists]) {
            NSDictionary<NSString *, id> * carDictionary = [snapshot data];
            NSString * idFound = [snapshot documentID];
            
            carFound = [[Car alloc] initWithDictionary:carDictionary];
            [carFound setAutoId:idFound];
            
            if (completeBlock) {
                NSLog(@"Car found in complete block: %@", carFound);
                completeBlock(carFound);
            }
            NSLog(@"Car found: %@", carFound);
            
        } else {
            NSLog(@"Document does not exist");
        }
    }];
    
    NSLog(@"Car: " );
}
// validate carId for empty spaces and nil
-(BOOL) carHasAValidId: (NSString* ) carId{
//remove empty spaces at the beginning and end
NSString* trimmedCarId = [carId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//check if there is something to search for after removing the empty spaces
if([trimmedCarId length] == 0){
    return NO;
}
return YES;
}
//Search Button action
- (IBAction)didPressSearchById:(id)sender {
    NSString * carId = [[self idTextField] text];
    
    if ([self carHasAValidId: carId]) {
        [self searchCarById:carId completeBlock:^(Car * car) {
            
            if (car != nil) {
                [[self makeTextField] setText:[car make]];
                [[self modelTextField] setText:[car model]];
                [[self yearTextField] setText:[car year]];
                [[self transmissionTextField] setText:[car transmission]];
                [[self drivetrainTextField] setText:[car drivetrain]];
                [[self engineTextField] setText:[car engine]];
                [[self priceTextField] setText:[car price]];
                [[self ratingTextField] setText:[car rating]];
                //[[self photoTextField] setText:[car photo]];
                //[[self photoImageView] setImage:[UIImage imageNamed:[_carsDictionary objectForKey:@"photo"]]];
                
                //Hardcoded
                self.firestore = [FIRFirestore firestore];
                
                FIRCollectionReference *carsCollectionRef = [[self firestore] collectionWithPath: @"SportsCars"];
                
                
                if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual:@"GR86"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"GR86Img"]];
                    
                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual:@"296 GTB Coupe"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"296Img"]];
                
                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual:@"220i M Sport Coupe"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"220iImg"]];

                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual: @"Vantage F1 Coupe"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"VantageImg"]];
                    
                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual: @"911 Carrera GTS Coupe"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"911Img"]];
                    
                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual: @"Artura"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"ArturaImg"]];
                
                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual: @"Huracan"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"HuracanImg"]];
                    
                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual: @"MC20 Coupe"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"MC20Img"]];
                    
                } else if ([carsCollectionRef queryWhereField:@"autoId" isEqualTo:carId] && [[car model] isEqual: @"Emira"]){
                    [[self photoImageView] setImage:[UIImage imageNamed:@"EmiraImg"]];
                    
                } else [[self photoImageView] setImage:[UIImage imageNamed:@"carDefault"]];
                
                
                [[self videoTextField] setText:[car video]];
            }
        }];
    }else {
        [self showUIAlertWithMessage:@"You must provide the car ID to search for" andTitle:@"Car Search Failed"];
        [[self idTextField] setText:@""];
    }
}

//findAll function declaration and definition
-(void) findAll: (void(^)(NSMutableDictionary *)) completion{
    //https://firebase.google.com/docs/firestore/query-data/listen
    [[self.firestore collectionWithPath:@"SportsCars"] addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        if(snapshot != nil){
            NSLog(@"Car found!!! %li documents in the db", [snapshot count]);
            if(completion){
                NSMutableDictionary *carsDictionary = [NSMutableDictionary new];
                for (FIRQueryDocumentSnapshot* snap in [snapshot documents]) {
                    NSDictionary *carDataDictionary = [snap data];
                    NSString *carId = [snap documentID];
                    
                    [carsDictionary setObject:carDataDictionary forKey:carId];
                }
                completion(carsDictionary);
            }
        }else{
            NSLog(@"No car data found.");
        }
        
    }];

}

-(BOOL) carHasAValidCarModel: (NSString* ) carModel{
    //remove empty spaces at the beginning and end
    NSString* trimmedCarModel = [carModel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //check if there is something to search for after removing the empty spaces
    if([trimmedCarModel length] == 0){
        return NO;
    }
    return YES;
}

- (IBAction)didPressSearcByCarModel:(id)sender {
    
    NSString *model  = [[self modelTextField] text];
    
    if ([self carHasAValidCarModel: model]) {
        FIRCollectionReference *carsCollectionRef = [[self firestore] collectionWithPath:@"SportsCars"];
        FIRQuery *query = [carsCollectionRef queryWhereField:@"model" isEqualTo:model];
        [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            if(error != nil){
                NSString *message = @"Oops. Unable to find car model. Try again.";

                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert];

                [self presentViewController:alert animated:YES completion:nil];

                int duration = 2; // duration in seconds

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            }
            else {
                NSLog(@"Found %li cars", [snapshot count]);
                if([snapshot count] > 0){
                    //FIRDocumentSnapshot *document = snapshot.documents.firstObject;
                    for (FIRDocumentSnapshot *document in [snapshot documents]) {
                        NSLog(@"CarId: %@", [document documentID]);
                        NSDictionary *myCarDictionary = [document data];
                        NSLog(@"car: %@", myCarDictionary);
                        Car* myCar = [[Car alloc] initWithDictionary:myCarDictionary];
                        [myCar setAutoId:[document documentID]];
                        
                        
                        [[self idTextField] setText:[myCar autoId]];
                        [[self makeTextField] setText:[myCar make]];
                        [[self modelTextField] setText:[myCar model]];
                        [[self yearTextField] setText:[myCar year]];
                        [[self transmissionTextField] setText:[myCar transmission]];
                        [[self drivetrainTextField] setText:[myCar drivetrain]];
                        [[self engineTextField] setText:[myCar engine]];
                        [[self priceTextField] setText:[myCar price]];
                        [[self ratingTextField] setText:[myCar rating]];
                        
                        self.firestore = [FIRFirestore firestore];
                        
                        FIRCollectionReference *carsCollectionRef = [[self firestore] collectionWithPath: @"SportsCars"];
                        
                        
                        if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"GR86"] && [model isEqual:@"GR86"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"GR86Img"]];


                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"Artura"] && [model isEqual:@"Artura"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"ArturaImg"]];
                            
                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"296 GTB Coupe"] && [model isEqual:@"296 GTB Coupe"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"296Img"]];
                            
                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"296 GTB Coupe"] && [model isEqual:@"220i M Sport Coupe"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"220iImg"]];
                        
                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"Vantage F1 Coupe"] && [model isEqual:@"Vantage F1 Coupe"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"VantageImg"]];
                            
                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"911 Carrera GTS Coupe"] && [model isEqual:@"911 Carrera GTS Coupe"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"911Img"]];
                            
                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"Huracan"] && [model isEqual:@"Huracan"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"HuracanImg"]];
                        
                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"MC20 Coupe"] && [model isEqual:@"MC20 Coupe"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"MC20Img"]];
                            
                        } else if ([carsCollectionRef queryWhereField:@"model" isEqualTo:@"Emira"] && [model isEqual:@"Emira"]){
                            [[self photoImageView] setImage:[UIImage imageNamed:@"EmiraImg"]];
                        
                        } else [[self photoImageView] setImage:[UIImage imageNamed:@"carDefault"]];
  
    
                    }
                        
                    NSString * message = [NSString stringWithFormat:@"All cars matching the name: %@ where found",model];
                    [self showUIAlertWithMessage:message andTitle:@"Car found"];
                }else{
                    [self showUIAlertWithMessage:@"Car model provided does not match any record in the database" andTitle:@"Search result"];
                }
            }
        }];
    } else {
        [self showUIAlertWithMessage:@"You must enter car model on the textfield provided" andTitle:@"Search result"];
    }
}


-(BOOL) update: (Car*) car{
    __block BOOL isUpdated = YES;
    
    //Fetch the document by using the Id
    FIRDocumentReference *carReference = [[[self firestore] collectionWithPath:@"SportsCars"] documentWithPath:[car autoId]];
    /**
            To update some fields of a document without overwriting the entire document, use the update() method.
            Else use setData with the merge property, in this case setData is recommended, I'm using update as demonstration
    */
    [carReference updateData:@{
        @"make": [car make],
        @"model": [car transmission],
        @"year": [car year],
        @"transmission": [car transmission],
        @"drivetrain": [car drivetrain],
        @"engine": [car engine],
        @"price": [car price],
        @"rating": [car rating],
        //@"photo": [car photo],
        //@"video": [car video],
    } completion:^(NSError * _Nullable error) {
        if(error != nil){
            NSLog(@"Error updating car data: %@", error);
            isUpdated = NO;
        }else{
            NSLog(@"Car data successfully updated");
        }
    }];
    return isUpdated;
}


@end
