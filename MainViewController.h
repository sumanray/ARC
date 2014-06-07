//
//  MainViewController.h
//  holocaust
//
//  Created by Suman Ray on 11/13/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "RearViewController.h"
#import "CustomIOS7AlertView.h"



@interface MainViewController : UIViewController<UIScrollViewDelegate,CustomIOS7AlertViewDelegate,MFMessageComposeViewControllerDelegate>{
    UIScrollView *scrollView;
    UIPanGestureRecognizer *panGestureRecognizer;
    UINavigationController *navController;
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *learnLabel;
    IBOutlet UILabel *visitLabel;
    IBOutlet UILabel *actLabel;
    IBOutlet UILabel *carouselLabelView;
}


@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UILabel *learnLabel;
@property (nonatomic, strong) UILabel *visitLabel;
@property (nonatomic, strong) UILabel *actLabel;
@property (nonatomic, strong) UILabel *carouselLabelView;

@end
