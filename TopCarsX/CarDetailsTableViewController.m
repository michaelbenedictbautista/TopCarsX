//
//  CarDetailsTableViewController.m
//  TopCarsX
//
//  Created by Mike on 30/7/2022.
//

#import "CarDetailsTableViewController.h"
#import "CarVideoTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#import "generateQRTableViewController.h"

@interface CarDetailsTableViewController ()

@property Car * selectedCar;

@property CarViewController * carViewController;

@end

@implementation CarDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.firestore = [FIRFirestore firestore];
    
    //CarViewController *carViewController = [[CarViewController alloc] init];
    [[self carViewController] setFirestore:[self firestore]];
    
    
    [[self photoImageView] setImage:[[self car] photo] ];
    [[self makeLabel] setText:[[self car] make]];
    [[self modelLabel] setText:[[self car] model]];
    [[self yearLabel] setText:[[self car] year]];
    [[self transimissionTextField] setText:[[self car] transmission] ];
    [[self drivetrainTextField] setText:[[self car] drivetrain]];
    [[self engineTextField] setText:[[self car] engine] ];
    [[self priceTextField] setText:[[self car] price] ];
    [[self ratingTextField] setText:[[self car] rating] ];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// action for edit icon
- (IBAction)didPressEdit:(id)sender {
    
    [self textFieldEnabled];
}

// Function enable textField
-(void) textFieldEnabled{
    [[self transimissionTextField] setEnabled:TRUE];
    [[self transimissionTextField] setBorderStyle:UITextBorderStyleBezel];
    [[self transimissionTextField] becomeFirstResponder];
    
    [[self drivetrainTextField] setEnabled:TRUE];
    [[self engineTextField] setEnabled:TRUE];
    [[self priceTextField] setEnabled:TRUE];
    [[self ratingTextField] setEnabled:TRUE];
    
    [[self updateButton] setEnabled:TRUE];
}

// Function disable textField
-(void) textFieldDisabled{
    [[self transimissionTextField] setEnabled:FALSE];
    [[self transimissionTextField] setBorderStyle:UITextBorderStyleNone];
    
    
    [[self drivetrainTextField] setEnabled:FALSE];
    [[self engineTextField] setEnabled:FALSE];
    [[self priceTextField] setEnabled:FALSE];
    [[self ratingTextField] setEnabled:FALSE];
    
    [[self updateButton] setEnabled:FALSE];
}

// Validate for update
-(BOOL) update: (Car*) car{
    __block BOOL isUpdated = YES;
    
    //Fetch the document by using the Id
    FIRDocumentReference *carReference = [[[self firestore] collectionWithPath:@"SportsCars"] documentWithPath:[car autoId]];
    /**
            To update some fields of a document without overwriting the entire document, use the update() method.
            Else use setData with the merge property, in this case setData is recommended, I'm using update as demonstration
    */
    [carReference updateData:@{
        //@"make": [car make],
        //@"model": [car model],
        //@"year": [car year],
        @"transmission": [car transmission],
        @"drivetrain": [car drivetrain],
        @"engine": [car engine],
        @"price": [car price],
        @"rating": [car rating],
        //@"photo": [car photo],
        //@"video": [car video]
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

// Action button for update
- (IBAction)didPressUpdate:(id)sender {
    // Assign the inputs from the textField to new variables.
    NSString *transmission = [[self transimissionTextField] text];
    NSString *drivetrain = [[self drivetrainTextField] text];
    NSString *engine = [[self engineTextField] text];
    NSString *price = [[self priceTextField] text];
    NSString *rating = [[self ratingTextField] text];
    
    NSString * model  = [[self modelLabel] text];
    
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
                        NSLog(@"Car: %@", myCarDictionary);
                        Car* myCar = [[Car alloc] initWithDictionary:myCarDictionary];
                        [myCar setAutoId:[document documentID]];
                                        
                        self.firestore = [FIRFirestore firestore];
                        
                        FIRCollectionReference *carsCollectionRef = [[self firestore] collectionWithPath: @"SportsCars"];
                        
                        
                        if ([carsCollectionRef queryWhereField:@"model" isEqualTo:[myCar model]]) {
                                Car * updatedCar = [[Car alloc] init];
                                
                                [updatedCar setAutoId:[myCar autoId]];
                                [updatedCar setMake:[myCar make]];
                                [updatedCar setModel:[myCar model]];
                                [updatedCar setYear:[myCar year]];
                                [updatedCar setTransmission:transmission];
                                [updatedCar setDrivetrain:drivetrain];
                                [updatedCar setEngine:engine];
                                [updatedCar setPrice:price];
                                [updatedCar setRating:rating];
                                //[updatedCar setPhoto:[myCar photo]];
                                [updatedCar setVideo:[myCar video]];
                        
                            if ([self update:updatedCar]) {
                                NSLog(@"Successfully updated!");
                                [self textFieldDisabled];
                            }else {
                                NSLog(@"Unsuccessful! Try again.");
                            }

                        } else  NSLog(@" 2this is my card ID %@", [myCar model]);
                            
                    }
                        
                }else{
                    NSLog (@"Car model provided does not match any record in the database");
                }
            }
        }];
}
        

//Validate for delete
-(BOOL) delete: (Car *) car {
    __block BOOL isDeleted = YES;
    
    // This is method to find specific autoId in a collection with document
    FIRDocumentReference * carReference = [[[self firestore] collectionWithPath:@"SportsCars"] documentWithPath:[car autoId]];
    
    // deleteDocumentWithCompletion is a method from FIRDocument for deleting a file
    [carReference deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error deleting car: %@", error);
            isDeleted = NO;
        }
    }];
    return isDeleted;
    
}

// Action delete button
- (IBAction)didPressDelete:(id)sender {
    
    NSString * model  = [[self modelLabel] text];
    
    
    FIRCollectionReference *carsCollectionRef = [[self firestore] collectionWithPath:@"SportsCars"];
    
      
            UIAlertController* alert = [[UIAlertController alloc] init];
            [alert setTitle:@"Delete car"];
            [alert setMessage:@"Are you sure you want to delete this car?"];
            [alert modalPresentationStyle];
            
            // Before presenting the alert, configure tsome actions
            UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //create a query to play with data already registered in the database
                FIRQuery *query = [carsCollectionRef queryWhereField:@"model" isEqualTo:model];
                //execute the query
                [query getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
                    if(error != nil){
                        NSLog(@"Error retrieving car data: %@", error);
                    }else{
                        
    
                        //FIRDocumentSnapshot *document = snapshot.documents.firstObject;
                        for (FIRDocumentSnapshot *document in [snapshot documents]) {
                            NSLog(@"DocumentId: %@", [document documentID]);
                            NSDictionary *myCarDictionary = [document data];
                            NSLog(@"Car: %@", myCarDictionary);
                            
                            Car* myCar = [[Car alloc] initWithDictionary:myCarDictionary];
                            [myCar setAutoId:[document documentID]];
                            
          
                            self.firestore = [FIRFirestore firestore];
                            
                            FIRCollectionReference *carsCollectionRef = [[self firestore] collectionWithPath: @"SportsCars"];
                            
                            if ([carsCollectionRef queryWhereField:@"model" isEqualTo:[myCar model]]) {
                                Car * deleteCar = [[Car alloc] init];
                                
                                [deleteCar setAutoId:[myCar autoId]];
                                
                                if ([self delete:deleteCar]) {
                                    NSLog(@"Successfully deleted!");
                                }else {
                                    NSLog(@"Unsuccessful! Try again.");
                                }
                                
                            }
                            
                        }
                    }
                    
                }];
                
            }];
            // Action for the cancel button
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
            // Add action to alert
            [alert addAction:yesAction];
            [alert addAction:cancelAction];

            [self presentViewController:alert animated:YES completion:nil];
            
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue destinationViewController] isKindOfClass:[ CarVideoTableViewController class]]) {
        CarVideoTableViewController* carVideoTableViewController = [segue destinationViewController ];
        [carVideoTableViewController setCar:[self car]];
        
    } else if ([[segue destinationViewController] isKindOfClass:[ generateQRTableViewController class]]) {
        generateQRTableViewController* generateQRTableViewControllerObject = [segue destinationViewController ];
        [generateQRTableViewControllerObject setCar:[self car]];
    }
}


-(void)playerFinished:(NSNotification *) notification {
    
    // AVPlayer finishes playing playerItem
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    [playerViewController dismissViewControllerAnimated:false completion:nil];
}


// Function to play sample video of a car
-(void) playMyVideo {
    
    //NSString* filePathLocalStorage= @"/Users/mike/Documents/Docs/AIT/Moblile App iOS/TopCarsX/TopCarsX/Assets.xcassets/EmiraImg.imageset"
    //NSURL *imageLocalURL = [NSURL fileURLWithPath:filePathLocalStorage]; // local storage
    //filePathLocalStorage may be from the Bundle or from the Saved file Directory.
    
    
    
    
    if ([[[self modelLabel] text] isEqual:@"Emira"]) {
        _URLAddress= @"https://firebasestorage.googleapis.com/v0/b/topcarsx-903d5.appspot.com/o/EmiraVid.mp4?alt=media&token=7c531d32-e09e-492c-bbd3-28096cff983a";
        
        // Initilialsie a URL object and pass URLAddress as an argument
        _URLVideo = [NSURL URLWithString:_URLAddress];
        
        // Initilialsie an AVplayer
        AVPlayer *avPlayer = [AVPlayer playerWithURL:_URLVideo];
        AVPlayerViewController * avPlayerViewController = [AVPlayerViewController new];
        avPlayerViewController.player = avPlayer;
        [avPlayerViewController.player play];// Play start automatically
        [self presentViewController:avPlayerViewController animated:YES completion:nil];
    
        AVPlayerItem *avPlayerItem = avPlayer.currentItem;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:avPlayerItem];
        
    }
}

// Action button to play video by call the playMyVideo function
- (IBAction)didPressPlay:(id)sender {
    [self playMyVideo];
}

// Action button to navigate in generateTableViewController
- (IBAction)didPressQrCode:(id)sender {
    NSLog(@"Navigate to QRCode Screen.");
}


//[self presentViewController:alert animated:YES completion:nil];
@end
