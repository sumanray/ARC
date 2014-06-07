//
//  AppDelegate.m
//  holocaust
//
//  Created by Suman Ray on 11/13/13.
//  Copyright (c) 2013 ATT. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "RearViewController.h"
#import "WikitudeViewController.h"

@implementation AppDelegate
@synthesize navController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = mainViewController;
	
   // mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    wikitudeViewController = [[WikitudeViewController alloc] initWithNibName:nil bundle:nil];
    rearViewController = [[RearViewController alloc] initWithNibName:nil bundle:nil];
    navController = [[UINavigationController alloc] initWithRootViewController:wikitudeViewController];
    navController.navigationBar.barStyle = UIBarStyleDefault;
    //navController.navigationBar.tintColor = [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    navController.navigationBar.tintColor = [UIColor redColor];
    ZUUIRevealController *revealController = [[ZUUIRevealController alloc] initWithFrontViewController:navController rearViewController:rearViewController];
    
    //navController.title = @"Halliburton";
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = revealController;
   // [self presentViewController:revealController animated:YES completion:nil];
    
 
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
