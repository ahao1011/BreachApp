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
#import "ViewCtrlLoading.h"
#import "AhTabBarButton.h"

@interface AHTabBarViewController ()<AhTabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic,weak) AhTabBar *customTabBar;

@end

@implementation AHTabBarViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    //初始化tabBar
    [self setUpTabBar];
    //初始化所有子控制器
    [self setUpAllshildVc];
    
}
#pragma mark -- 初始化所有子控制器
- (void)setUpAllshildVc{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"List.plist" ofType:nil];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    
    for (int i = 0; i<dataArr.count; i++) {
        
        NSDictionary *dic = dataArr[i];
        NSString *nameClass= dic[@"name"];
        Class aclass = NSClassFromString(nameClass);
        UIViewController *vc = [[aclass alloc]init];
                if (i==0) {
                    vc.tabBarItem.badgeValue = @"4";  //测试
                }
        [self setupChildViewController:vc title:dic[@"title"] imageName:dic[@"icon"] selectedImageName:dic[@"icon_sel"]];
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
- (BOOL)tabBar:(AhTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    
    
    if (to==3 && ![UserInfo DefaultUser].Login) {
        
        
        ViewCtrlLoading*login = [[ViewCtrlLoading alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
        [[UserInfo DefaultUser].tabBarVcController presentViewController:navi animated:YES completion:nil];

        return NO;
        
    }else{
        self.selectedIndex = to;
        return YES;
    }
}

//- (void)buttonClick:(AhTabBarButton*)button{
//    // 通知代理
//    
//    //    MYLog(@"%zd===%zd",self.selectedBtn.tag,button.tag);
//    
//    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
//        
//        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedBtn.tag to:(int)button.tag];
//    }
//    // 设置按钮状态
//    self.selectedBtn.selected = NO;
//    button.selected = YES;
//    self.selectedBtn = button;
//    
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


- (void)initView{
    
    //  设置tabBar的背景图  系统默认时白色
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    
}

#pragma mark - 登录检测的实现
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]&& ![UserInfo DefaultUser].Login)
    {
        ViewCtrlLoading*login = [[ViewCtrlLoading alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
        [tabBarController presentViewController:navi animated:YES completion:nil];
        return NO;
    }
    return YES;
}


@end






























