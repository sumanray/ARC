//
//  WikitudeViewController.m
//  holocaust
//
//  Created by Suman Ray on 11/14/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import "WikitudeViewController.h"
#import "UIDevice+SystemVersion.h"
#import "ZUUIRevealController.h"
#import "MainViewController.h"
#import "RearViewController.h"
#import <WikitudeSDK/WTArchitectView.h>

#import "UINavigationController+Rotation_iOS6.h"



@interface WikitudeViewController ()<WTArchitectViewDelegate>

@end

@implementation WikitudeViewController
@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize headerLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ( [WTArchitectView isDeviceSupportedForARMode:WTARMode_Geo] ) {
            
            if (!_architectView) {
                self.architectView = [[WTArchitectView alloc] initWithFrame:self.view.bounds];
                [self.architectView initializeWithKey:@"tW3Ht861dC8lNC2/xnahrP7DRI7nqfXDGZfUvdeIGJsc64QLICf0leLIO50svo8me8yrGBcglCEHwAQEhqs8eOceTQ0iXJhF6Glf016W/tDsCSXMetFz4vdZIHzOdNOOBJEKuIEPYZgyffutNigYtdWpPzS33L1OQLoVkdQ3z/NTYWx0ZWRfX21xcPVHf8nkO6IcVarrd+BPN3s78E/Ac39sjGX90LKiVK47DeMMovn5X5X3vXIcwrxe3WRZqL6sczpdObKvll+Qwvpbrnej1ausee5uUCCXFC6oevbcnuWyqgYXzctjCjrJlcdfzL1EgPi9W4i87bnT1uf8IYISiPwBlK7vNvLpBIfryzyn9t4EKMGr5X0GTgXA11G5BJW2wkgukMSt7zp8fE1XurT/C97tTtN9P/w5lyWnpjm/1Qt8n409QxB09A9ZW2x9vcOoTzyCKQyTXduWyhW4hv6gXHZUU5A88PJBGtFpX63f40VURgi+6hMNy2Q4I57Ck0d+NTJHQnPbm2NoHKiAkFr5LS2A91lnhF3BI9Qx8YPpjStPNslW93NJPXOstmSFDLep9MpNx+tLzPMRBj5HLjSTPCzWZSQSuXSj31hc/nwoaVl+0MvQzNC1YQdS1QcjeQx5Ln6nFaW+eCmRHOOAZZQJUJeaVvLSMll+zaYwZ+WrIYDCMx/nCwjtQ7Y+Voj2sivGIxPNrcDUuWul6q2D3WJmUwjquibs2M97lLljwojpgLfRf8hWynpvnfliTgk2OZUT96+vcwLW3FHkCLFteuRQ2g==" motionManager:nil];
            }
        } else {
            
            NSLog(@"This device is not capable of running ARchitect Worlds. Requirements are: iOS 5 or higher, iPhone 3GS or higher, iPad 2 or higher. Note: iPod Touch 4th and 5th generation are only supported in WTARMode_IR.");
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 
    
    if ( [UIDevice isRunningiOS7] ) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;


    self.architectView.frame = CGRectMake(44,0,screenWidth,screenHeight-44);
    self.view = self.architectView;
    
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    //[bar setBarStyle:UIBarStyleBlackTranslucent];
    //bar.tintColor  = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(120,5,76,27)];
	//logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	logoView.image = [UIImage imageNamed:@"logo.png"];
	[bar addSubview:logoView];
    
    UIImageView *infoView = [[UIImageView alloc] initWithFrame:CGRectMake(288,9,22,22)];
	//logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	infoView.image = [UIImage imageNamed:@"info.png"];
	[bar addSubview:infoView];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    UIImageView *iconView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list.png"]];
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)]){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:iconView];
        UITapGestureRecognizer *tapList = [[UITapGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealToggle:)];
        tapList.numberOfTapsRequired = 1;
        tapList.numberOfTouchesRequired = 1;
        [iconView setUserInteractionEnabled:YES];
        [iconView addGestureRecognizer:tapList];
        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
        [self.navigationController.navigationBar setTranslucent:YES];
        self.navigationController.navigationBar.tintColor= [UIColor redColor] ;
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
        [self.navigationController.navigationBar addGestureRecognizer:self.panGestureRecognizer];
    }else{
        //abort();
    }
    
    UITapGestureRecognizer *tapInfoView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInfoView:)];
    tapInfoView.numberOfTapsRequired = 1;
    tapInfoView.numberOfTouchesRequired = 1;
    [infoView setUserInteractionEnabled:YES];
    [infoView addGestureRecognizer:tapInfoView];
   
    
    NSURL *architectWorldUrl = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    [self.architectView loadArchitectWorldFromUrl:architectWorldUrl];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.architectView start];
    if ( [self.architectView isRunning] ) {
        
        NSLog(@"ARchitect is running with version: %@", [self.architectView versionNumber]);
    }else {
        NSLog(@"WTARchitectView wasn't able to start. Please check e.g. the -ObjC linker flag in your project settings.");
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.architectView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WTARViewController Protocol implementation
- (void)loadARchitectWorldForWorldName:(NSString *)worldName
{
    if (worldName) {
        
        NSString *worldDirectory = [@"ArchitectWorld" stringByAppendingPathComponent:worldName];
        
        NSURL *absoluteWorldURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:worldDirectory];
        if (absoluteWorldURL) {
            [self.architectView loadArchitectWorldFromUrl:absoluteWorldURL];
        }else {
            NSLog(@"Unable to find ARchitect World path in App resouce bundle: %@", worldName);
        }
        
    }else {
        NSLog(@"Undefined ARchitect world name");
    }
}

- (void)loadARchitectWorldFromURL:(NSURL *)url
{
    if (url) {
        [self.architectView loadArchitectWorldFromUrl:url];
    }
}

#pragma mark - Managing WTArchitectView Lifecycle

- (void)pauseARchitectWorld
{
    if ([self.architectView isRunning]) {
        [self.architectView stop];
    }
}

- (void)resumeARchitectWorld
{
    if (![self.architectView isRunning]) {
        [self.architectView start];
    }
}


#pragma mark - iOS Rotation Handling
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.architectView setShouldRotate:YES toInterfaceOrientation:toInterfaceOrientation];
}

#pragma mark iOS 6
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark iOS 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)architectView:(WTArchitectView *)architectView invokedURL:(NSURL *)url{
    NSLog(@"hey");
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





@end
