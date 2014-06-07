//
//  RearViewController.m
//  holocaust
//
//  Created by Suman Ray on 11/15/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import "RearViewController.h"
#import "ZUUIRevealController.h"

#import "MainViewController.h"
#import "DashBoardViewController.h"
#import "CalendarViewController.h"

@interface RearViewController ()

@end

@implementation RearViewController
@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize imgView;
@synthesize rearTableView;

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
    rearTableView = [[UITableView alloc]init];
    rearTableView.scrollEnabled = YES;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    //sCGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
   
    if(screenHeight>560)
    {
        rearTableView.frame = CGRectMake(0, 20, 320, 240);
    }else{
         rearTableView.frame = CGRectMake(0, 20, 320, 240);
    }
    //[self.rearTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [rearTableView layoutIfNeeded];
    rearTableView.dataSource = self;
    rearTableView.delegate = self;
   
    [rearTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
//    NSLog(@"%2f - %2f", self.rearTableView.bounds.size.width, self.rearTableView.bounds.size.height);
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(125,290, 134,262)];
    iconView.image=[UIImage imageNamed:@"img_sidebar.png"];
    [self.view addSubview:iconView];
//
    [self.view addSubview:rearTableView];
    
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
	
	if (indexPath.row == 0)
	{
		UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,9, 22, 22)];
        imv.image=[UIImage imageNamed:@"icon_text.png"];
        cell.textLabel.text = @"        Text Message";
        [cell.contentView addSubview:imv];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 1)
	{
		UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,9, 22, 22)];
        imv.image=[UIImage imageNamed:@"icon_charts.png"];
        cell.textLabel.text = @"        Dashboard";
        [cell.contentView addSubview:imv];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 2)
	{
		UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,9, 22, 22)];
        imv.image=[UIImage imageNamed:@"icon_calendar.png"];
        cell.textLabel.text = @"        Calendar";
        [cell.contentView addSubview:imv];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 3)
	{
		UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,9, 22, 22)];
        imv.image=[UIImage imageNamed:@"todolist.png"];
        cell.textLabel.text = @"        To-Do List";
        [cell.contentView addSubview:imv];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 4)
	{
		UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,9, 22, 22)];
        imv.image=[UIImage imageNamed:@"icon_setting.png"];
        cell.textLabel.text = @"        Settings";
        [cell.contentView addSubview:imv];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
    
        MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
        RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:nil bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        ZUUIRevealController *revealController = [[ZUUIRevealController alloc] initWithFrontViewController:navController rearViewController:rearViewController];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self presentViewController:revealController animated:NO completion:nil];
    }else if(indexPath.row == 1){
        
        DashBoardViewController *dashboardViewController = [[DashBoardViewController alloc] initWithNibName:nil bundle:nil];
        RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:nil bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:dashboardViewController];
        ZUUIRevealController *revealController = [[ZUUIRevealController alloc] initWithFrontViewController:navController rearViewController:rearViewController];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self presentViewController:revealController animated:NO completion:nil];
        
    }else if(indexPath.row == 2){
        
        CalendarViewController *calendarViewController = [[CalendarViewController alloc] initWithNibName:nil bundle:nil];
        RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:nil bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:calendarViewController];
        ZUUIRevealController *revealController = [[ZUUIRevealController alloc] initWithFrontViewController:navController rearViewController:rearViewController];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self presentViewController:revealController animated:NO completion:nil];
        
    }
}




- (void)tapLogoView:(UIGestureRecognizer *)recognizer{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NAVIGATION"
                                                    message:@"Offers the user to various features and functions during the visit as well as tools and resources that are useful outside of the museum."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//    UILabel *contactLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,0,62,30)];
//    contactLabel.textColor = [UIColor blackColor];
//	contactLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    contactLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	contactLabel.text = @"Contact";
//	contactLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:contactLabel];
//
//    UILabel *membershipLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,0,92,30)];
//    membershipLabel.textColor = [UIColor blackColor];
//	membershipLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    membershipLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	membershipLabel.text = @"Membership";
//	membershipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:membershipLabel];
//
//    UILabel *missionLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,20,62,30)];
//    missionLabel.textColor = [UIColor blackColor];
//	missionLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    missionLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	missionLabel.text = @"Mission";
//	missionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:missionLabel];
//
//    UILabel *donateLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,20,92,30)];
//    donateLabel.textColor = [UIColor blackColor];
//	donateLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    donateLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	donateLabel.text = @"Donate";
//	donateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:donateLabel];
//
//    UILabel *learnLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0,55,320,30)];
//    learnLabel.textColor = [UIColor blackColor];
//    learnLabel.backgroundColor = [UIColor whiteColor];
//	learnLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:16 ];
//    learnLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	learnLabel.text = @"   LEARN";
//	learnLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:learnLabel];
//
//    UILabel *overviewLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,90,62,30)];
//    overviewLabel.textColor = [UIColor blackColor];
//	overviewLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    overviewLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	overviewLabel.text = @"Overview";
//	overviewLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:overviewLabel];
//
//    UILabel *timelinesLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,90,92,30)];
//    timelinesLabel.textColor = [UIColor blackColor];
//	timelinesLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    timelinesLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	timelinesLabel.text = @"Timelines";
//	timelinesLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:timelinesLabel];
//
//    UILabel *gamesLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,110,62,30)];
//    gamesLabel.textColor = [UIColor blackColor];
//	gamesLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    gamesLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	gamesLabel.text = @"Games";
//	gamesLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:gamesLabel];
//
//    UILabel *favoritesLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,110,92,30)];
//    favoritesLabel.textColor = [UIColor blackColor];
//	favoritesLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    favoritesLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	favoritesLabel.text = @"Favorites";
//	favoritesLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:favoritesLabel];
//
//    UILabel *visitLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0,145,320,30)];
//    visitLabel.textColor = [UIColor blackColor];
//    visitLabel.backgroundColor = [UIColor whiteColor];
//	visitLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:16 ];
//    visitLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	visitLabel.text = @"   VISIT";
//	visitLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:visitLabel];
//
//    //Add tap action for visitLabel
//    UITapGestureRecognizer *tapVisitLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVisitLabel:)];
//    tapVisitLabel.numberOfTapsRequired = 1;
//    tapVisitLabel.numberOfTouchesRequired = 1;
//    [visitLabel setUserInteractionEnabled:YES];
//    [visitLabel addGestureRecognizer:tapVisitLabel];
//
//    UIImageView *visitImage = [[UIImageView alloc]initWithFrame:CGRectMake(200,150,13,17)];
//    visitImage.image = [UIImage imageNamed:@"NAV_visit_icon_sm.png"];
//    [scrollView addSubview:visitImage];
//
//    UILabel *directionsLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,180,62,30)];
//    directionsLabel.textColor = [UIColor blackColor];
//	directionsLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    directionsLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	directionsLabel.text = @"Directions";
//	directionsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:directionsLabel];
//
//    UILabel *myTicketsLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,180,92,30)];
//    myTicketsLabel.textColor = [UIColor blackColor];
//	myTicketsLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    myTicketsLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	myTicketsLabel.text = @"My Tickets";
//	myTicketsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:myTicketsLabel];
//
//    UILabel *prepareLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,200,62,30)];
//    prepareLabel.textColor = [UIColor blackColor];
//	prepareLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    prepareLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	prepareLabel.text = @"Prepare";
//	prepareLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:prepareLabel];
//
//    UILabel *beginLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,200,92,30)];
//    beginLabel.textColor = [UIColor blackColor];
//	beginLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    beginLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	beginLabel.text = @"Begin";
//	beginLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:beginLabel];
//
//    //Tap Begin Journey
//
//    UITapGestureRecognizer *tapJourneyView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapJourneyView:)];
//    tapJourneyView.numberOfTapsRequired = 1;
//    tapJourneyView.numberOfTouchesRequired = 1;
//    [beginLabel setUserInteractionEnabled:YES];
//    [beginLabel addGestureRecognizer:tapJourneyView];
//
//    //Tap image header
//    UITapGestureRecognizer *tapLogoView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLogoView:)];
//    tapLogoView.numberOfTapsRequired = 1;
//    tapLogoView.numberOfTouchesRequired = 1;
//    [imgView setUserInteractionEnabled:YES];
//    [imgView addGestureRecognizer:tapLogoView];
//
//    UILabel *actLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0,235,320,30)];
//    actLabel.textColor = [UIColor blackColor];
//    actLabel.backgroundColor = [UIColor whiteColor];
//	actLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:16 ];
//    actLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	actLabel.text = @"   ACT";
//	actLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:actLabel];
//
//    UILabel *coonectLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,270,62,30)];
//    coonectLabel.textColor = [UIColor blackColor];
//	coonectLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    coonectLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	coonectLabel.text = @"Connect";
//	coonectLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:coonectLabel];
//
//    UILabel *nearMeLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,270,92,30)];
//    nearMeLabel.textColor = [UIColor blackColor];
//	nearMeLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    nearMeLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	nearMeLabel.text = @"Near Me";
//	nearMeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:nearMeLabel];
//
//    UILabel *eventsLabel  = [[UILabel alloc]initWithFrame:CGRectMake(30,290,62,30)];
//    eventsLabel.textColor = [UIColor blackColor];
//	eventsLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    eventsLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	eventsLabel.text = @"Events";
//	eventsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:eventsLabel];
//
//    UILabel *feedbackLabel  = [[UILabel alloc]initWithFrame:CGRectMake(120,290,92,30)];
//    feedbackLabel.textColor = [UIColor blackColor];
//	feedbackLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16 ];
//    feedbackLabel.textAlignment = NSTextAlignmentLeft;
//	//[learnLabel setTextAlignment:UITextAlignmentCenter];
//	feedbackLabel.text = @"Feedback";
//	feedbackLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:feedbackLabel];
//
//    CGRect screenBound = [scrollView bounds];
//    CGSize screenSize = screenBound.size;
//    //CGFloat screenWidth = screenSize.width;
//    CGFloat screenHeight = screenSize.height;
//    CGFloat ht = screenHeight-325;
//
//
//    UILabel *emptyLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0,325,320,ht)];
//    emptyLabel.backgroundColor = [UIColor whiteColor];
//    emptyLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [scrollView addSubview:emptyLabel];
//
//

