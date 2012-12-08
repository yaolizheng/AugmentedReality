//
//  ARView.h
//  demo
//
//  Created by Tao Zong on 10/15/12.
//  Copyright (c) 2012 Tao Zong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>


@interface ARView : UIView  <CLLocationManagerDelegate, UIAccelerometerDelegate> {
}

@property (nonatomic, retain) NSArray *placesOfInterest;

- (void)start;
- (void)stop;
- (void)startCameraPreview;
- (void)stopCameraPreview;
@end

