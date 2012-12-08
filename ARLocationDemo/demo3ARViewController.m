//
//  demo3ARViewController.m
//  demo
//
//  Created by Tao Zong on 10/15/12.
//  Copyright (c) 2012 Tao Zong. All rights reserved.
//

#import "demo3ARViewController.h"

#import "PlaceOfInterest.h"
#import "ARView.h"
#import "demo3AppDelegate.h"
#import "Place.h"
#import <CoreLocation/CoreLocation.h>
#import "demo3DetailedController.h"
#import "WebService.h"

@implementation demo3ARViewController


@synthesize placesOfInterest;
@synthesize hud;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray *arr = [NSArray arrayWithObjects:NSLocalizedString(@"ALL",NULL),NSLocalizedString(@"ATM", NULL),NSLocalizedString(@"Bank", NULL),nil];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arr];
    seg.segmentedControlStyle = UISegmentedControlSegmentCenter;
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    [self showLoading:@"all"];
    
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    if([CLLocationManager locationServicesEnabled]) {
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            NSArray *arr = [NSArray arrayWithObjects:NSLocalizedString(@"ALL",NULL),NSLocalizedString(@"ATM", NULL),NSLocalizedString(@"Bank", NULL),nil];
            UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arr];
            seg.segmentedControlStyle = UISegmentedControlSegmentCenter;
            seg.selectedSegmentIndex = app.segNum;
            [seg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            self.navigationItem.titleView = seg;
            //[self reload];
            [super viewWillAppear:animated];
            ARView *arView = (ARView *)self.view;
            [arView start];
        }
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
            NSArray *arr = [NSArray arrayWithObjects:NSLocalizedString(@"ALL",NULL),NSLocalizedString(@"ATM", NULL),NSLocalizedString(@"Bank", NULL),nil];
            UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arr];
            seg.segmentedControlStyle = UISegmentedControlSegmentCenter;
            seg.selectedSegmentIndex = 0;
            [seg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            self.navigationItem.titleView = seg;
            //[self reload];
            [super viewWillAppear:animated];
            ARView *arView = (ARView *)self.view;
            [arView startCameraPreview];
            [[[[UIAlertView alloc] initWithTitle:@"WARNING"
                                         message:@"Location services are disabled.  Please enable location service for this app, otherwise we cannot get location information."
                                        delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil] autorelease] show];
        }
    }
    else {
        NSArray *arr = [NSArray arrayWithObjects:NSLocalizedString(@"ALL",NULL),NSLocalizedString(@"ATM", NULL),NSLocalizedString(@"Bank", NULL),nil];
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arr];
        seg.segmentedControlStyle = UISegmentedControlSegmentCenter;
        seg.selectedSegmentIndex = 0;
        [seg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = seg;
        //[self reload];
        [super viewWillAppear:animated];
        ARView *arView = (ARView *)self.view;
        [arView startCameraPreview];
        [[[[UIAlertView alloc] initWithTitle:@"WARNING"
                                     message:@"Location services are disabled.  Please enable location service for this app, otherwise we cannot get location information."
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil] autorelease] show];
    }
    
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
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        ARView *arView = (ARView *)self.view;
        [arView stop];
        
    }
    else {
        ARView *arView = (ARView *)self.view;
        [arView stopCameraPreview];
    }
}

- (void) reload
{
    ARView *arView = (ARView *)self.view;
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    
    
	placesOfInterest = [NSMutableArray arrayWithCapacity:[app.places count]];
	for (int i = 0; i < [app.places count]; i++) {
        Place *p = [app.places objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:@"button(2).png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.center = CGPointMake(200.0f, 200.0f);
        [button setTitle:p.name forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
        
        button.titleLabel.font = [UIFont fontWithName:@"Courier" size:20];
        [button setBackgroundColor:[UIColor clearColor]];
        CGSize size = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
        button.bounds = CGRectMake(0.0f, 0.0f, size.width + 10, size.height + 2);
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        PlaceOfInterest *poi = [PlaceOfInterest placeOfInterestWithView:button at:[[[CLLocation alloc] initWithLatitude:p.location.coordinate.latitude longitude:p.location.coordinate.longitude] autorelease]];
        button.tag = i;
        [placesOfInterest insertObject:poi atIndex:i];
	}
	[arView setPlacesOfInterest:placesOfInterest];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}

-(IBAction)buttonPress:(id)sender{
    UIButton* btn = (UIButton *) sender;
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    app.ID = btn.tag;

    demo3DetailedController *detail = [[demo3DetailedController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)showLoading: (NSString *)type {
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
    [mainWindow addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.delegate = self;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [indicator startAnimating];
    hud.customView = indicator;
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"Loading...";
    [hud showWhileExecuting:@selector(sendRequest:) onTarget:self withObject:type animated:YES];
    
}

- (void)sendRequest: (NSString *)type {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    [WebService getLocation:app.location withType:type];
    [self reload];
    
}



- (void)segmentAction:(id)sender{
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    switch ([sender selectedSegmentIndex]){
        case 0:{
            [self showLoading:@"all"];
            app.segNum = 0;
        }
            break;
            
        case 1:{
            [self showLoading:@"atm"];
            
            app.segNum = 1;
        }
            break;
        case 2:{
            [self showLoading:@"bank"];
            app.segNum = 2;
        }
            break;
        default:
            break;
    }
}

@end
