//
//  CalendarViewController.m
//  ARC
//
//  Created by Suman Ray on 6/7/14.
//  Copyright (c) 2014 ATT. All rights reserved.
//

#import "CalendarViewController.h"
#import "WikitudeViewController.h"
#import "ZUUIRevealController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController
@synthesize panGestureRecognizer = _panGestureRecognizer;

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
    // Do any additional setup after loading the view from its nib.
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBarStyle:UIBarStyleBlackTranslucent];
    bar.tintColor  = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(120,5,76,27)];
	//logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	logoView.image = [UIImage imageNamed:@"logo.png"];
	[bar addSubview:logoView];
    
    UIImageView *infoView = [[UIImageView alloc] initWithFrame:CGRectMake(288,9,22,22)];
	//logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	infoView.image = [UIImage imageNamed:@"info.png"];
	[bar addSubview:infoView];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    UIImageView *backIconView = [[UIImageView alloc] initWithFrame:CGRectMake(5,10,24,24)];
	//logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	backIconView.image = [UIImage imageNamed:@"back-icon.png"];
	[bar addSubview:backIconView];
    
    //Tap back button
    
    UITapGestureRecognizer *tapBackLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackLabel:)];
    tapBackLabel.numberOfTapsRequired = 1;
    tapBackLabel.numberOfTouchesRequired = 1;
    [backIconView setUserInteractionEnabled:YES];
    [backIconView addGestureRecognizer:tapBackLabel];
    
    UITapGestureRecognizer *tapInfoView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInfoView:)];
    tapInfoView.numberOfTapsRequired = 1;
    tapInfoView.numberOfTouchesRequired = 1;
    [infoView setUserInteractionEnabled:YES];
    [infoView addGestureRecognizer:tapInfoView];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,64,320,480)];
	//logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	backgroundView.image = [UIImage imageNamed:@"calendar.png"];
	[self.view addSubview:backgroundView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchDialog
{
    // Here we need to pass a full frame
    
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 60)];
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 270, 40)];
    labelView.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
	labelView.textColor = [UIColor whiteColor];
	labelView.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:13 ];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.numberOfLines = 0;
    
    labelView.text = @"Augmented Reality Connector Version 1.0.1";
    [demoView addSubview:labelView];
    
    return demoView;
}

- (void)tapInfoView:(UIGestureRecognizer *)recognizer{
    [self launchDialog];
}

- (void)tapBackLabel:(UIGestureRecognizer *)recognizer{
    WikitudeViewController *wikitudevIewController = [[WikitudeViewController alloc] initWithNibName:nil bundle:nil];
    RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:nil bundle:nil];
    navController = [[UINavigationController alloc] initWithRootViewController:wikitudevIewController];
    ZUUIRevealController *revealController = [[ZUUIRevealController alloc] initWithFrontViewController:navController rearViewController:rearViewController];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:revealController animated:NO completion:nil];
}


@end
