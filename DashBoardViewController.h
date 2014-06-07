//
//  DashBoardViewController.h
//  ARC
//
//  Created by Suman Ray on 6/7/14.
//  Copyright (c) 2014 ATT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RearViewController.h"
#import "CustomIOS7AlertView.h"

@interface DashBoardViewController : UIViewController<UIWebViewDelegate,CustomIOS7AlertViewDelegate>{

    UIPanGestureRecognizer *panGestureRecognizer;
    UINavigationController *navController;
}

@property (nonatomic, retain) UIWebView *performanceWebView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end
