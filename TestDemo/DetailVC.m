//
//  DetailVC.m
//  TestDemo
//
//  Created by 孟庆宇 on 2019/12/20.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:jumpButton];
    
    jumpButton.frame = CGRectMake(100, 100, 100, 100);
    jumpButton.backgroundColor = [UIColor greenColor];
    [jumpButton setTitle:@"detail" forState:UIControlStateNormal];
    [jumpButton addTarget:self action:@selector(gotoNextVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gotoNextVC
{
    
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
