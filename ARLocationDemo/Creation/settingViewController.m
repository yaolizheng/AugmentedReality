//
//  settingViewController.m
//  NaviSto
//
//  Created by Yaoli Zheng on 11/15/12.
//
//

#import "settingViewController.h"
#import "demo3AppDelegate.h"
@interface settingViewController ()

@end

@implementation settingViewController

@synthesize seg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Setting", nill);
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    if ([[app.bank lowercaseString] rangeOfString:@"citibank"].location != NSNotFound) {
        seg.selectedSegmentIndex = 1;
    }
    else {
        seg.selectedSegmentIndex = 0;
    }
    
    [seg addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
}

- (void) pickOne:(id)sender{
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    app.bank = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [seg release];
    [super dealloc];
}
@end
