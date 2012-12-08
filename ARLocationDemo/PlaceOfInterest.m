//
//  PlaceOfInterest.m
//  demo
//
//  Created by Tao Zong on 10/15/12.
//  Copyright (c) 2012 Tao Zong. All rights reserved.
//

#import "PlaceOfInterest.h"

@implementation PlaceOfInterest

@synthesize view;
@synthesize location;

- (id)init
{
    self = [super init];
    if (self) {
        view = nil;
        location = nil;
    }
    return self;
}

- (void)dealloc
{
	[view release];
	[location release];
	[super dealloc];
}

+ (PlaceOfInterest *)placeOfInterestWithView:(UIView *)view at:(CLLocation *)location
{
	PlaceOfInterest *poi = [[[PlaceOfInterest alloc] init] autorelease];
	poi.view = view;
	poi.location = location;
	return poi;
}

@end
