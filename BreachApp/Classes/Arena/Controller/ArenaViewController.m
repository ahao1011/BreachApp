//
//  ArenaViewController.m
//  BreachApp
//
//  Created by ah on 16/3/28.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "ArenaViewController.h"
#import "shareButton.h"
#import "ViewCtrlSeason.h"

@interface ArenaViewController ()

@end

@implementation ArenaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLeftNavItem:NO];
    [self configView];
}

- (void)configView{
    
    CGFloat AdsW = K_ScreenWidth;
    CGFloat AdsH = AdsW * 0.35;
#warning 后期替换成轮播图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AdsW, AdsH)];
    view.backgroundColor = AHRandomColor;
    [self.view addSubview:view];
    
    CGFloat BackH = AdsH;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, AdsH, K_ScreenWidth, BackH)];
    backView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:backView];
    
    CGFloat btnW = 80;
    CGFloat btnH = btnW;
    CGFloat leftBtnX = (K_ScreenWidth - 2*btnW)*0.25;
    CGFloat leftBtnY = (BackH - btnH)*.5;
    
    shareButton *leftBtn = [[shareButton alloc]initWithFrame:CGRectMake(leftBtnX, leftBtnY, btnW, btnH)];
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn setATitle:@"赛季"];
    [leftBtn setAImage:[UIImage imageNamed:@"close"]];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:leftBtn];
    
    CGFloat RigthX = CGRectGetMaxX(leftBtn.frame)+ 2*leftBtnX;
    
    shareButton *rightBtn = [[shareButton alloc]initWithFrame:CGRectMake(RigthX, leftBtnY, btnW, btnH)];
    rightBtn.backgroundColor = [UIColor orangeColor];
    [rightBtn setATitle:@"约球"];
    [rightBtn setAImage:[UIImage imageNamed:@"close"]];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightBtn];
    
    
    CGFloat imgW = 130;
    CGFloat imgH = 200;
    CGFloat imgX = (K_ScreenWidth - imgW)*.5;
    CGFloat imgY = K_ScreenHeight- 30-64-49-imgH;  // 30为距底部的距离
    UIImageView *BackImg = [[UIImageView alloc]initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
    BackImg.backgroundColor = AHRandomColor;
#warning 需要图片
    [self.view addSubview:BackImg];
    
    
}

- (void)leftAction{
    
    ViewCtrlSeason *season = [[ViewCtrlSeason alloc]init];
    [self.navigationController pushViewController:season animated:YES];
}

- (void)rightAction{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
