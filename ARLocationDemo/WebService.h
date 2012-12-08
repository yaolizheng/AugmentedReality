//
//  WebService.h
//  MapWithXML
//
//  Created by Yaoli Zheng on 11/4/12.
//  Copyright (c) 2012 Yaoli Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface WebService : NSObject
+ (void) getLocation: (CLLocation *) location withType: (NSString *) type;
@end
