//
//  BaseViewController.m
//  BabyDemo
//
//  Created by ah on 15/10/14.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "BaseViewController.h"




@interface BaseViewController ()

@end

@implementation BaseViewController{
    
    UIView *EffectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 取消Ios7之后UIscrollowView及其子类  在有导航条时 有时会自动下移44点的问题
    

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self setupForDismissKeyboard];
//    [self creatNoti];
    
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




@end
