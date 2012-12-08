//
//  demo3MapViewController.m
//  demo
//
//  Created by Yaoli Zheng on 9/26/12.
//  Copyright (c) 2012 Yaoli Zheng. All rights reserved.
//

#import "demo3MapViewController.h"
#import "Place.h"
#import "demo3AppDelegate.h"
#import "WebService.h"
#import "demo3DetailedController.h"

@interface demo3MapViewController ()

@end

@implementation demo3MapViewController
@synthesize mapView;
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
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    seg.segmentedControlStyle = UISegmentedControlSegmentCenter;
    seg.selectedSegmentIndex = app.segNum;
    [seg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    
    if([CLLocationManager locationServicesEnabled]) {
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            MKCoordinateRegion newRegion = MKCoordinateRegionMake(app.location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
            
            [self.mapView setRegion:newRegion animated:NO];
            self.mapView.mapType = MKMapTypeStandard;
            self.mapView.delegate = self;
            [self.mapView setCenterCoordinate:app.location.coordinate];
            [self reloadPin];
            [self showLoading:@"all"];
        }
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){            [[[[UIAlertView alloc] initWithTitle:@"WARNING"
                                                                                                                                  message:@"Location services are disabled.  Please enable location service for this app, otherwise we cannot get location information."
                                                                                                                                 delegate:nil
                                                                                                                        cancelButtonTitle:@"OK"
                                                                                                                        otherButtonTitles:nil] autorelease] show];
        }
    }
    else {
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
    //[self setMapView:nil];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    [mapView release];
    [super dealloc];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    if ([[[annotation title] lowercaseString] isEqualToString:@"your current location"]) {
        return nil;
    }
    NSArray *t = [[annotation title] componentsSeparatedByString:@"|"];
    NSString *title = [t objectAtIndex:0];
    int ID = [[t objectAtIndex:1] intValue];
    ((MKUserLocation *)annotation).title = title;
    title = [title lowercaseString];
    MKAnnotationView *annView = [[MKAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
  
    if ([title rangeOfString:@"citibank"].location != NSNotFound) {
        if ([title rangeOfString:@"atm"].location != NSNotFound) {
            UIImage *image = [self imageWithImage:[UIImage imageNamed:@"AtmIcon.gif"] scaledToSize:CGSizeMake(30, 30)];
            annView.image =  image;
        }
        else {
            
            UIImage *image = [self imageWithImage:[UIImage imageNamed:@"CitiButton.png"] scaledToSize:CGSizeMake(30, 30)];
            
            annView.image = image;        }
        UIView *leftCAV = [[UIView alloc] initWithFrame:CGRectMake(0,0,23,23)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageWithImage:[UIImage imageNamed:@"CitiIcon.gif"] scaledToSize:CGSizeMake(23, 23)]];
        [leftCAV addSubview : imageView];
        UILabel *FirstLine = [[UILabel alloc] init];
        [FirstLine setText: @"line1"];
        [leftCAV addSubview : FirstLine];
        UILabel *SecondLine = [[UILabel alloc] init];
        [SecondLine setText: @"line2"];
        [leftCAV addSubview : SecondLine];
        annView.leftCalloutAccessoryView = leftCAV;
    }
    
    else if ([title rangeOfString:@"bank of america"].location != NSNotFound) {
        if ([title rangeOfString:@"atm"].location != NSNotFound) {
            UIImage *image = [self imageWithImage:[UIImage imageNamed:@"AtmIcon.gif"] scaledToSize:CGSizeMake(30, 30)];
            annView.image =  image;
        }
        else {
            
            UIImage *image = [self imageWithImage:[UIImage imageNamed:@"BoaButton.png"] scaledToSize:CGSizeMake(30, 30)];
            
            annView.image = image;//[UIImage imageNamed:@"CitiIcon.gif"] ;
        }
        UIView *leftCAV = [[UIView alloc] initWithFrame:CGRectMake(0,0,23,23)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageWithImage:[UIImage imageNamed:@"BoaIcon.gif"] scaledToSize:CGSizeMake(23, 23)]];
        [leftCAV addSubview : imageView];
        UILabel *FirstLine = [[UILabel alloc] init];
        [FirstLine setText: @"line1"];
        [leftCAV addSubview : FirstLine];
        UILabel *SecondLine = [[UILabel alloc] init];
        [SecondLine setText: @"line2"];
        [leftCAV addSubview : SecondLine];
        annView.leftCalloutAccessoryView = leftCAV;
        
    }
    else if ([title rangeOfString:@"ATM"].location != NSNotFound) {
        annView.image = [ UIImage imageNamed:@"AtmIcon.gif" ];
    }
    else
        annView.image = [ UIImage imageNamed:@"BankButton.gif" ];
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    infoButton.tag = ID;
    [infoButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    annView.rightCalloutAccessoryView = infoButton;
    annView.canShowCallout = YES;
    return annView;
}

-(void)btnClick:(id)sender
{
    UIButton* btn = (UIButton *) sender;
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    app.ID = btn.tag;
    demo3DetailedController *detail = [[demo3DetailedController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)reloadPin {
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    float longitude = app.location.coordinate.longitude;
    float latitude = app.location.coordinate.latitude;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    NSArray *oldAnnotations=[self.mapView annotations];
    [self.mapView removeAnnotations:oldAnnotations];
    MKPointAnnotation *annotation1 = [[MKPointAnnotation new] init];
    
    [annotation1 setCoordinate:coordinate];
    [annotation1 setTitle:@"your current location"];
    [self.mapView addAnnotation:annotation1];
    for(int i = 0; i < [app.places count]; i++) {
        Place *p = [app.places objectAtIndex:i];
        MKPointAnnotation *annotation2 = [[MKPointAnnotation new] init];
        
        [annotation2 setCoordinate:p.location.coordinate];
        NSString *title = [NSString stringWithFormat:@"%@%@%d", p.name, @"|", i];
        [annotation2 setTitle: title];
        [self.mapView addAnnotation:annotation2]; }
}

- (void)showLoading: (NSString *)type {
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
    [mainWindow addSubview:hud];    hud.delegate = self;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    [indicator startAnimating];
    hud.customView = indicator;
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"Loading...";
    [hud showWhileExecuting:@selector(sendRequest:) onTarget:self withObject:type animated:YES];
    
}

- (void)sendRequest: (NSString *)type {
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    [WebService getLocation:app.location withType:type];
    [self reloadPin];
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

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    //NSLog(@"I finished loading.");
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    if(app.mapInit == false) {
        MKCoordinateRegion newRegion = MKCoordinateRegionMake(app.location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
        ;
        [self.mapView setRegion:newRegion];
        app.mapInit = true;
    }
}

@end
