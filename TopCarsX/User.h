//
//  User.h
//  TopCarsX
//
//  Created by Mike on 29/7/2022.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property NSString* firstName;
@property NSString* lastName;
@property NSString* email;
@property NSString* password;
@property UIImage* photo;

//- (instancetype)initWithName: (NSString*) firstName
//                       lastName: (NSString*) lastName
//                       email: (NSString*) email
//                    password: (NSString*) password
//                       photo: (UIImage*) photo;
//-(BOOL) isValid;


@end

NS_ASSUME_NONNULL_END
