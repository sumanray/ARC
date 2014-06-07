//
//  CalendarViewController.h
//  ARC
//
//  Created by Suman Ray on 6/7/14.
//  Copyright (c) 2014 ATT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "MainViewController.h"

@interface CalendarViewController : UIViewController<CustomIOS7AlertViewDelegate>{
    UIPanGestureRecognizer *panGestureRecognizer;
    UINavigationController *navController;
}
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
