//
//  demo3ViewController.m
//  NaviSto
//
//  Created by Guangrui Su on 11/4/12.
//  Copyright (c) 2012 Guangrui Su. All rights reserved.
//

#import "demo3ViewController.h"
#import "demo3AppDelegate.h"
#import "demo3ARViewController.h"

@interface demo3ViewController ()

@end

@implementation demo3ViewController

@synthesize locManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    app.segNum = 0;
    if(app.bank == nil)
        app.bank = @"BANK";
    locManager = [[CLLocationManager alloc]init];
    locManager.delegate = self;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    locManager.distanceFilter = 100;
    [locManager startUpdatingLocation];
    
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    [locManager stopUpdatingLocation];
	[locManager release];
	locManager = nil;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocationCoordinate2D loc = [newLocation coordinate];
    float longitude = loc.longitude;
    float latitude = loc.latitude;
    if(longitude != 0.0 && latitude != 0.0) {
        demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
        app.location = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
        //NSLog(@"Response: %f", longitude);
        //NSLog(@"Response: %f", latitude);

    }

}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorized) {
        
    }
    else if(status == kCLAuthorizationStatusDenied) {
        [[[[UIAlertView alloc] initWithTitle:@"WARNING"
                                     message:@"Location services are disabled.  Please enable location service for this app, otherwise we cannot get location information."
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil] autorelease] show];
    }
}


- (void)dealloc {
    [locManager stopUpdatingLocation];
	[locManager release];
	locManager = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
