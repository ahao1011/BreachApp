//
//  AHNavigationController.m
//  aiduobaoDemo
//
//  Created by ah on 15/9/29.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "AHNavigationController.h"

@interface AHNavigationController ()

@end

@implementation AHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  系统第一次使用这个类时调用
 */
+ (void)initialize{
    
    //3. 设置导航栏主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"persontopbg"] forBarMetrics:UIBarMetricsDefault];
    //设置字体颜色
    NSMutableDictionary *attr = [[NSMutableDictionary alloc]init];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:25];
    navBar.titleTextAttributes= attr;
}


@end
