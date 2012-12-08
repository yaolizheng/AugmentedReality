//
//  Place.h
//  NaviSto
//
//  Created by Yaoli Zheng on 11/5/12.
//  Copyright (c) 2012 Tao Zong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Place : NSObject

@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;

+ (Place *)placeAt:(CLLocation *)location withName:(NSString *)name withAddress: (NSString *)address withPhone: (NSString *) phone withState: (NSString *)state withCity: (NSString *)city;

@end
