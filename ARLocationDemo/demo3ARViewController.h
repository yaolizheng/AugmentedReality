//
//  demo3ARViewController.h
//  demo
//
//  Created by Tao Zong on 10/15/12.
//  Copyright (c) 2012 Tao Zong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class ARView;
@interface demo3ARViewController : UIViewController <MBProgressHUDDelegate>
@property (retain, nonatomic) NSMutableArray *placesOfInterest;
@property (retain, nonatomic) MBProgressHUD *hud;

@end
