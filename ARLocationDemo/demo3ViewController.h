//
//  demo3ViewController.h
//  NaviSto
//
//  Created by Guangrui Su on 11/4/12.
//  Copyright (c) 2012 Guangrui Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface demo3ViewController : UIViewController <CLLocationManagerDelegate>
@property (retain, nonatomic) CLLocationManager *locManager;

@end
