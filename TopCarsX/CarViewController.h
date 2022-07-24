//
//  CarViewController.h
//  TopCarsX
//
//  Created by Mike on 11/7/2022.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseDatabase;

@interface CarViewController : UIViewController

//@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRFirestore *firestore;

-(void) findAll: (void(^)(NSMutableDictionary *)) completion;

@end

