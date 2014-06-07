//
//  MainViewController.m
//  holocaust
//
//  Created by Suman Ray on 11/13/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import "MainViewController.h"
#import "ZUUIRevealController.h"
#import "iCarousel.h"
#import "WikitudeViewController.h"

@interface MainViewController ()<iCarouselDataSource, iCarouselDelegate>
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) UINavigationItem *navItem;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MainViewController
@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize scrollView;
@synthesize headerLabel;
@synthesize learnLabel;
@synthesize visitLabel;
@synthesize actLabel;
@synthesize carouselLabelView;

int p = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        //set up data
        
        self.items =  [NSMutableArray arrayWithObjects:@"carousel_image1.png",
                      @"carousel_image2.png",
                      @"carousel_image5.png",
                      @"carousel_image3.png",
                      @"carousel_image4.png",
                       nil];
    }
    return self;
}

- (void)dealloc
{
	//it's a good idea to set these to nil here to avoid
	//sending messages to a deallocated viewcontroller
	_carousel.delegate = nil;
	_carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
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
	
	UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,400)];
    backgroundView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [self.view addSubview:backgroundView];
   
    
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    //CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
   
    

   	
	//create carousel
	_carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0,80,320,250)];
	_carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
   // _carousel.type = iCarouselTypeCoverFlow2;
    _carousel.type = iCarouselTypeInvertedTimeMachine;
	_carousel.delegate = self;
	_carousel.dataSource = self;
    
    self.carouselLabelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 310, 320, 40)];
    self.carouselLabelView.backgroundColor = [UIColor clearColor];
	self.carouselLabelView.textColor = [UIColor whiteColor];
	self.carouselLabelView.font = [UIFont fontWithName:@"Avenir-Light" size:20 ];
    self.carouselLabelView.textAlignment = NSTextAlignmentCenter;
    self.carouselLabelView.text = @"MOM";
    [self.view addSubview:carouselLabelView];

    
	//add carousel to view
	[self.view addSubview:_carousel];
    UIButton *callButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton.layer setCornerRadius:10];
    [[callButton layer] setMasksToBounds:YES];
    [callButton setFrame:CGRectMake(30, 460, 260, 40)];
	[callButton setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    [callButton setTitle:@"Send Message" forState:UIControlStateNormal];
    [callButton addTarget:self
               action:@selector(CallMethod:)
     forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:callButton];
		
}

-(void)CallMethod:(id)sender{
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    NSArray *recipients = [[NSArray alloc]init];
  
    
    NSString *message = [[NSString alloc]init];
    if(p==0){
    message = @"Mom can you come home please? I am missing you.";
        recipients = @[@"9139569166", @"4047977582"];
    }else if(p==1){
    message = @"Dad can you come home please? I am missing you.";
        recipients = @[@"4046682488"];
    }else if(p==2){
        message = @"Nurse Jackie this is an emergency. Come home immediately!";
        recipients = @[@"9139569166", @"4047977582"];
    }else if(p==3){
    message = @"Grandma can you come home please? I am missing you.";
        recipients = @[@"9139569166", @"4047977582"];
    }else if(p==4){
    message = @"Grandad can you come home please? I am missing you.";
        recipients = @[@"4046682488"];
    }
    
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipients];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
    self.navItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
   
  //  [self launchDialog:index];
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


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
   return [_items count];
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
   int index = carousel.currentItemIndex;
    if(index == 0){
        carouselLabelView.text = @"MOM";
        p = 0;
    }else if(index == 1){
        carouselLabelView.text = @"DAD";
        p = 1;
    }else if(index == 2){
        carouselLabelView.text = @"NURSE JACKIE";
        p = 2;
    }else if(index == 3){
        carouselLabelView.text = @"GRANDMA";
        p = 3;
    }else if(index == 4){
        carouselLabelView.text = @"GRANDAD";
        p = 4 ;
    }
    
}



- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
  
    
    view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_items objectAtIndex:index]]];
    return view;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

