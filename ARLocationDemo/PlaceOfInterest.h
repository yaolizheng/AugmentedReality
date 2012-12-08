//
//  PlaceOfInterest.h
//  demo
//
//  Created by Tao Zong on 10/15/12.
//  Copyright (c) 2012 Tao Zong. All rights reserved.
//
#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface PlaceOfInterest : NSObject

@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) CLLocation *location;

+ (PlaceOfInterest *)placeOfInterestWithView:(UIView *)view at:(CLLocation *)location;

@end
