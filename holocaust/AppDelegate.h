//
//  AppDelegate.h
//  holocaust
//
//  Created by Suman Ray on 11/13/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "WikitudeViewController.h"
#import "ZUUIRevealController.h"
#import "RearViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    
    MainViewController *mainViewController;
    RearViewController *rearViewController;
    UINavigationController *navController;
    WikitudeViewController *wikitudeViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;

@end
