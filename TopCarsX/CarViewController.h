//
//  CarViewController.h
//  TopCarsX
//
//  Created by Mike on 11/7/2022.
//

#import <UIKit/UIKit.h>
#import "Car.h"
@import Firebase;
@import FirebaseDatabase;


@interface CarViewController : UIViewController

//@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRFirestore *firestore;
@property (strong, nonatomic) NSMutableDictionary *carsDictionary;
@property (strong, nonatomic) NSDictionary * carNSDictionary;


-(void) findAll: (void(^)(NSMutableDictionary *)) completion;

-(BOOL) add: (Car*) Car;

@property (weak, nonatomic) IBOutlet UIScrollView *carScrollViewController;

@end

