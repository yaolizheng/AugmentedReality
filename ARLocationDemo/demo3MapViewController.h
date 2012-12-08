//
//  demo3MapViewController.h
//  demo
//
//  Created by Yaoli Zheng on 9/26/12.
//  Copyright (c) 2012 Yaoli Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MBProgressHUD.h"

@interface demo3MapViewController : UIViewController <MKMapViewDelegate, MBProgressHUDDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) MBProgressHUD *hud;
@end
