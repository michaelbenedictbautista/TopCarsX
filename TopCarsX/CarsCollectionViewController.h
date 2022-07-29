//
//  CarsCollectionViewController.h
//  TopCarsX
//
//  Created by Mike on 28/7/2022.
//

#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface CarsCollectionViewController : UICollectionViewController

@property (nonatomic,strong) FIRFirestore * firestore;
@property (strong, nonatomic) NSMutableDictionary *carsDictionary;
@property (strong, nonatomic) IBOutlet UICollectionView *carsCollectionView;


@end

NS_ASSUME_NONNULL_END
