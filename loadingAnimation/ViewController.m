//
//  ViewController.m
//  loadingAnimation
//
//  Created by 王斌 on 16/3/22.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import "ViewController.h"

#import "LoadingView.h"

@interface ViewController ()

@property(nonatomic, strong)LoadingView *loading;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
   
    
    self.loading = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    self.loading.center = self.view.center;
    [self.view addSubview:self.loading];
//    [self addLoadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLoadingView{
    
//    UIView *backgroundMaskView = [[UIView alloc] initWithFrame:self.view.frame];
//    backgroundMaskView.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:1.0f];
//    backgroundMaskView.alpha = 0.7f;
    
    LoadingView *loadingView = [[LoadingView alloc] init];
//    [backgroundMaskView addSubview:loadingView];
    [self.view addSubview:loadingView];
}



- (IBAction)start:(UIButton *)sender {

    
    [self.loading startAnimate]; //手动开始动画
}
- (IBAction)stop:(UIButton *)sender {

    [self.loading stopAnimate]; //结束动画
}

@end
