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
    //1. 设置导航栏主题
    [self setupNavBarTheme];
    //2. 设置导航栏按钮的主题
    [self setupBarButtonItemTheme];
    
    
}
/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme{
    
    // 注意:navigationItem.title的颜色 字体大小 属于 UINavigationBar  文字内容不属于
    //取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 导航栏镂空颜色(返回按钮颜色)
    [navBar setTintColor:[UIColor whiteColor]];
    // 导航栏背景
    
    UIImage *backgroundImage = [UIImage imageNamed:@"navBackimage_2"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    //设置字体颜色
    NSMutableDictionary *attr = [[NSMutableDictionary alloc]init];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:25];
    navBar.titleTextAttributes= attr;
}
/**
 *  设置导航栏按钮的主题
 */
+ (void)setupBarButtonItemTheme{
    
    UIBarButtonItem *item =  [UIBarButtonItem appearance];
    // 设置文字属性 大小 颜色
    NSMutableDictionary *attr = [[NSMutableDictionary alloc]init];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //  返回按钮后的文字大小
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:0];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    [item setTitleTextAttributes:attr forState:UIControlStateHighlighted];
}

//重写push方法

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(self.viewControllers.count>0){// 不加这个判断在back时 tabBar会消失
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/**
 *  始终有拖拽导航效果
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

#pragma mark - 实现delegate中的方法
// 清除系统tabBarButton上的badgeView (每次导航控制器跳转时显示VC前都会调用)
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    //    //获取主窗口的根控制器tabBarController
    //    UITabBarController *tabBarController = (UITabBarController *)SCKeyWindow.rootViewController;
    //
    //    // 移除系统tabBarButton上的badgeView
    //    for (UIView *view in tabBarController.tabBar.subviews) {
    //
    //        for (UIView *subview in view.subviews) {
    //
    //            if ([subview isKindOfClass: NSClassFromString(@"_UIBadgeView")]) {    //  要学习
    //
    //                [subview removeFromSuperview];
    //            }
    //        }
    //    }
}



@end
