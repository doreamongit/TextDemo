//
//  UINavigationController+InterfaceOrientation.m
//  AHVideoPlayerSDKDemo
//
//  Created by 孟庆宇 on 2020/1/7.
//  Copyright © 2020 Damon. All rights reserved.
//

#import "UINavigationController+InterfaceOrientation.h"

@implementation UINavigationController(InterfaceOrientation)

- (BOOL)shouldAutorotate{
    if (self.viewControllers.count > 0)
        return [[self.viewControllers lastObject] shouldAutorotate];
    
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    if (self.viewControllers.count > 0)
        return [[self.viewControllers lastObject] supportedInterfaceOrientations];
    else
        return UIInterfaceOrientationMaskAll;
}

@end
