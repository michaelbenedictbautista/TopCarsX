//
//  Car.h
//  TopCarsX
//
//  Created by Mike on 24/7/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject

@property NSString * autoId;
@property NSString * make;
@property NSString * model;
@property NSString * year;
@property NSString * transmission;
@property NSString * drivetrain;
@property NSString * engine;
@property NSString * price;
@property NSString * rating;
@property NSString * photo;
@property NSString * video;

-(instancetype) initWithName: (NSString*)make autoId:(NSString *) autoId
               model:(NSString *) model year:(NSString *) year transmission:(NSString *) transmission
              drivetrain:(NSString *) drivetrain engine:(NSString *) engine price:(NSString *) price
              rating:(NSString *) rating photo:(NSString *) photo video:(NSString *) video;

-(instancetype) initWithDictionary: (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
