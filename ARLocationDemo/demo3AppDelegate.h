//
//  demo3AppDelegate.h
//  NaviSto
//
//  Created by Guangrui Su on 11/4/12.
//  Copyright (c) 2012 Guangrui Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface demo3AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableArray *places;
@property (nonatomic, retain) CLLocation *location;
@property int ID;
@property (strong,nonatomic) NSString *bank;
@property BOOL mapInit;
@property int segNum;
@end
