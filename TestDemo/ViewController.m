//
//  ViewController.m
//  TestDemo
//
//  Created by 孟庆宇 on 2019/12/20.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "ViewController.h"
#import "DetailVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:jumpButton];
    
    jumpButton.frame = CGRectMake(100, 100, 100, 100);
    jumpButton.backgroundColor = [UIColor greenColor];
    [jumpButton setTitle:@"jump" forState:UIControlStateNormal];
    [jumpButton addTarget:self action:@selector(gotoNextVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gotoNextVC
{
    DetailVC *dVC = [[DetailVC alloc] init];
    [self.navigationController pushViewController:dVC animated:YES];
}

@end
