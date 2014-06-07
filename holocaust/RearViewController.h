//
//  RearViewController.h
//  holocaust
//
//  Created by Suman Ray on 11/15/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RearViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UIImageView *imgView;
    UINavigationController *navController;
    UIPanGestureRecognizer *panGestureRecognizer;
    UITableView  *rearTableView;
}
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, retain) UITableView *rearTableView;
@end
