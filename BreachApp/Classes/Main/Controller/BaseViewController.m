//
//  BaseViewController.m
//  BabyDemo
//
//  Created by ah on 15/10/14.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"




@interface BaseViewController ()

@property (nonatomic,assign,getter=ShowLeftItem)BOOL isShowLeftItem;  //  默认显示

@end

@implementation BaseViewController{
    
    UIView *EffectView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  scrollView的布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = K_BackColor;
    
    
    // 取消Ios7之后UIscrollowView及其子类  在有导航条时 有时会自动下移44点的问题
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self setupForDismissKeyboard];
    [self configDataBase];
    [self showLeftNavItem:YES];
    
//    [self creatNoti];  // 暂时取消
    
}

- (void)showLeftNavItem:(BOOL)show{
    
    if (show) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"LeftDis" sleIcon:@"LeftDis" target:self action:@selector(Doback)];
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)configDataBase{
    
}



- (void)Doback{
    
    if (self!=self.navigationController.viewControllers[0]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//  实现键盘弹起时点击界面时收键盘

- (void)setupForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉  注意 这样做可能会将一些其他的点击手势的传递链打掉 
    [self.view endEditing:YES];
}

#pragma mark -  键盘通知
- (void)creatNoti{
    
    //获取通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //让self监听键盘弹出的通知,注册通知
    //Observer：接收通知的对象
    //selector：接收到通知之后调用的方法
    //name:通知的名字
    [nc addObserver:self selector:@selector(keybardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘隐藏
    [nc addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -  键盘显示
-(void)keybardWillShow:(NSNotification *)notify
{
    NSTimeInterval time = [[notify.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:time animations:^{        
        CGFloat Magin;
        
        if (Iphone5) {
            Magin=50;
        }else if (Iphone6){
            Magin = 10;
        }else if (Iphone6P){
            Magin=0;
        }else{
            Magin = 95;
        }
        self.view.bounds = CGRectMake(0, Magin, self.view.bounds.size.width, self.view.bounds.size.height);
        
    }];
}

#pragma mark -键盘隐藏
-(void)keyboardWillHidden
{
    [UIView animateWithDuration:0.25 animations:^{
       
        CGRect bounds = self.view.bounds;
        bounds.origin = CGPointZero;
        self.view.bounds = bounds;
        
        
    }];
}
#pragma mark- 信息提示类

- (void)showWaitMessage:(NSString*)message{
    
     [MBProgressHUD showMessage:message];
}

- (void)showWaitView:(BOOL)IsShow{
    
    if (IsShow) {
        [MBProgressHUD showMessage:@"加载中"];
    }else{
        [MBProgressHUD hideHUD];
    }
}

- (void)showMessage:(NSString *)message{
    
     [MBProgressHUD showTitleMessage:message];
}

- (void)showAlertMessage:(NSString *)alertMes{
    
    [AhAlertView alertViewWithTitle:@"提示" message:alertMes];
}
#pragma mark- 上拉加载  下拉刷新

- (void)setTableViewHeader:(UITableView*)tableView Action:(void (^)())Action{
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:Action];
    
    // 马上进入刷新状态
    [tableView.mj_header beginRefreshing];
}

- (void)setTableViewFooter:(UITableView*)tableView Action:(void (^)())Action{
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:Action];
}


- (void)EndFreshTableView:(UITableView*)tableView IsAllData:(BOOL)isAll{
    
    if (isAll) {
        
        [tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
        
    }
}

#pragma mark- 导航栏左返回按钮 


#pragma mark- 输入框代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField!=nil) {
        [textField resignFirstResponder];
    }
    [self presentViewController:self animated:YES completion:^{
        
    }];
    return YES;
}

#pragma mark- presnet动画

- (void)PresentViewController:(UIViewController *)vc Animated:(BOOL)animated AnimationType:(NSString*)type completion:(void (^)(void))completion{
    
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
//    animation.timingFunction = UIViewAnimationCurveEaseOut;
    animation.type = @"ceshi ";
    animation.subtype = kCAGravityLeft;
    [self.view.window.layer addAnimation:animation forKey:@"ceshi-09"];
    [self presentViewController:vc animated:NO completion:completion];
    
}






@end
