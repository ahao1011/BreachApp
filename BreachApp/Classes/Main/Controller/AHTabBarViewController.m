//
//  AHTabBarViewController.m
//  aiduobaoDemo
//
//  Created by ah on 15/9/29.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "AHTabBarViewController.h"
#import "CampViewController.h"
#import "CircleViewController.h"
#import "ArenaViewController.h"
#import "MeViewController.h"
#import "UIImage+Ah.h"
#import "AhTabBar.h"

@interface AHTabBarViewController ()<AhTabBarDelegate>

@property (nonatomic,weak) AhTabBar *customTabBar;

@end

@implementation AHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabBar
    [self setUpTabBar];
    //初始化所有子控制器
    [self setUpAllshildVc];
    
    
    
}
#pragma mark -- 初始化所有子控制器
- (void)setUpAllshildVc{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"List.plist" ofType:nil];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    int i = 0;
    for (NSDictionary *dic in dataArr) {
        NSString *nameClass= dic[@"name"];
        Class aclass = NSClassFromString(nameClass);
        UIViewController *vc = [[aclass alloc]init];
        if (i==0) {
            vc.tabBarItem.badgeValue = @"4";
        }
        [self setupChildViewController:vc title:dic[@"title"] imageName:dic[@"icon"] selectedImageName:dic[@"icon_sel"]];
        i++;
    }
}
#pragma mark -- 初始化一个子控制器
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    AHNavigationController *nav = [[AHNavigationController alloc]initWithRootViewController:childVc];
    childVc.navigationItem.title = title; // 导航栏标题
    UIImage *selImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageWithName:imageName] selectedImage:selImage];
    if ([childVc isKindOfClass:[CampViewController class]] ) {
        
    }
    [self addChildViewController:nav];
    // 添加tabBar内部按钮
    
    [self.customTabBar addTabBarButtonWithItem:nav.tabBarItem];
    
}
#pragma mark -- 初始化TabBar
- (void)setUpTabBar{
    AhTabBar *customTabBar = [[AhTabBar alloc]init];
    customTabBar.delegate = self;
    customTabBar.frame  = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
}
#pragma mark -- AhTabBarDelegate
//监控tabBar的改变
- (void)tabBar:(AhTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    
    self.selectedIndex = to;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


@end






























