//
//  Car.m
//  TopCarsX
//
//  Created by Mike on 24/7/2022.
//

#import "Car.h"

@implementation Car

-(instancetype) initWithName:(NSString *)make autoId:(NSString *)autoId model:(NSString *)model year:(NSString *)year transmission:(NSString *)transmission drivetrain:(NSString *)drivetrain engine:(NSString *)engine price:(NSString *)price rating:(NSString *)rating photo:(NSString *)photo video:(NSString *)video {
    
    self = [super init];
    if(self) {
        _make = make;
        _model = model;
        _year = year;
        _transmission = transmission;
        _drivetrain = drivetrain;
        _engine = engine;
        _price = price;
        _rating = rating;
        //_photo = photo;
        _photo = [UIImage imageNamed:photo];
        _video = video;
    }
    return self;
}

-(instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        _autoId = dictionary[@"autoId"];
        _make = dictionary[@"make"];
        _model = dictionary[@"model"];
        _year = dictionary[@"year"];
        _transmission = dictionary[@"transmission"];
        _drivetrain = dictionary[@"drivetrain"];
        _engine = dictionary[@"engine"];
        _price = dictionary[@"price"];
        _rating = dictionary[@"rating"];
        //_photo = dictionary[@"photo"];
        _photo = [UIImage imageNamed: dictionary[@"photo"]];
        _video = dictionary[@"video"];
        
    }
    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"make: %@ model: %@ year: %@ transmission: %@ drivetrain: %@ engine: %@ price: %@ rating: %@ photo: %@ video: %@", _make, _model, _year, _transmission, _drivetrain, _engine, _price, _rating, _photo, _video];
}
@end
