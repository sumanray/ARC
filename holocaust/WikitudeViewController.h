//
//  WikitudeViewController.h
//  holocaust
//
//  Created by Suman Ray on 11/14/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WikitudeSDK/WTArchitectView.h>
#import "CustomIOS7AlertView.h"

@interface WikitudeViewController : UIViewController<UIScrollViewDelegate,CustomIOS7AlertViewDelegate>{
    UINavigationController *navController;
    UIPanGestureRecognizer *panGestureRecognizer;
    IBOutlet UILabel *headerLabel;
}



- (void)loadARchitectWorldForWorldName:(NSString *)worldName;

- (void)pauseARchitectWorld;
- (void)resumeARchitectWorld;


@property (nonatomic, strong) WTArchitectView               *architectView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@end
