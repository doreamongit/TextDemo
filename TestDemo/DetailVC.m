//
//  DetailVC.m
//  TestDemo
//
//  Created by 孟庆宇 on 2019/12/20.
//  Copyright © 2019 Damon. All rights reserved.
//

#import "DetailVC.h"
#import "NSObject+Instance.h"

@interface DetailVC ()
{
    UIView * blueView;
}

@property (strong, nonatomic) UIView * greenView;

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
    
    
//    NSObject *ab = [[NSObject alloc] init];
//
//    UIImage *image = [UIImage imageNamed:@"dd"];
//
//    UIImage *image1 = [[UIImage alloc] initWithData:nil];
//
//    NSLog(@"-----:%@",image1);
    
    UIView *redView = [[UIView alloc] init];
    [self.view addSubview:redView];
    
//    NSLog(@"---wer--:%@",redView);
    
    redView.frame = CGRectMake(100, 200, 100, 100);
    redView.backgroundColor = [UIColor redColor];
//    NSLog(@"--23423---:%@",[self nameWithInstance:redView]);
//
//    self.greenView = [[UIView alloc] init];
//    [self.view addSubview:self.greenView];
//
//    NSLog(@"--23423---1:%@",[self nameWithInstance:self.greenView]);
//
//    blueView = [[UIView alloc] init];
//    [self.view addSubview:blueView];
//
//    NSLog(@"--23423---1:%@",[self nameWithInstance:blueView]);
    
    
    
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
