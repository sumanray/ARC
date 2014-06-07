//
//  UINavigationController+Rotation_iOS6.m
//  SDKExamples
//
//  Created by Andreas Schacherbauer on 6/12/13.
//  Copyright (c) 2013 Wikitude. All rights reserved.
//

#import "UINavigationController+Rotation_iOS6.h"

@implementation UINavigationController (Rotation_iOS6)

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}


@end
