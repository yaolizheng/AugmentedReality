//
//  Place.m
//  NaviSto
//
//  Created by Yaoli Zheng on 11/5/12.
//  Copyright (c) 2012 Tao Zong. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize name;
@synthesize location;
@synthesize address;
@synthesize phone;
@synthesize state;
@synthesize city;

- (id)init
{
    self = [super init];
    if (self) {
        name = nil;
        location = nil;
    }
    return self;
}

- (void)dealloc
{
	
	[location release];
	[super dealloc];
}

+ (Place *)placeAt:(CLLocation *)location withName:(NSString *)name withAddress: (NSString *)address withPhone: (NSString *) phone withState: (NSString *)state withCity: (NSString *)city{
	Place *p = [[[Place alloc] init] autorelease];
	p.name = name;
	p.location = location;
    p.phone = phone;
    p.city = city;
    p.state = state;
    p.address = address;
	return p;
}

@end
