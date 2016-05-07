//
//  UITextField+Extion.m
//  BreachApp
//
//  Created by ah on 16/5/4.
//  Copyright © 2016年 ah. All rights reserved.
//

#define K_h 44

#import "UITextField+Extion.h"



@implementation UITextField (Extion)

// 代码
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addAccessoryView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAccessoryView];
    }
    return self;
}
// xib
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addAccessoryView];
    }
    return self;
}

- (void)addAccessoryView{
    
    
    //    self.btn0 set
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, K_h)];
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    self.inputAccessoryView = view;
    
    CGFloat btn0W =  30;
    CGFloat btn0H =  30;
    CGFloat btn0X =  0;
    CGFloat btn0Y =  (K_h-btn0H)*.5;
    
    UIButton *btn0 = [[UIButton alloc]initWithFrame:CGRectMake(btn0X, btn0Y, btn0W, btn0H)];
    btn0.imageView.contentMode = UIViewContentModeScaleToFill;
    btn0.tag = 9910;
    CGFloat btn1W =  30;
    CGFloat btn1H =  30;
    CGFloat btn1X =  btn0W+3;
    CGFloat btn1Y =  (K_h-btn0H)*.5;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(btn1X, btn1Y, btn1W, btn1H)];
    btn1.imageView.contentMode = UIViewContentModeScaleToFill;
    btn1.tag = 9911;
    CGFloat Rbtn1H =  40;
    CGFloat Rbtn1W =  40;
    CGFloat Rbtn1X =  view.frame.size.width - Rbtn1W-3;
    CGFloat Rbtn1Y =  (view.frame.size.height-Rbtn1H)*.5;
    
    
    UIButton *Rbtn = [[UIButton alloc]initWithFrame:CGRectMake(Rbtn1X, Rbtn1Y, Rbtn1W, Rbtn1H)];
    
    CGFloat LableY =  0;
    CGFloat LableH =  view.frame.size.height;
    CGFloat LableX =  btn1X + btn1W;
    CGFloat LableW =  Rbtn1X-LableX;
    UILabel *textLable = [[UILabel alloc]initWithFrame:CGRectMake(LableX, LableY, LableW, LableH)];
    textLable.tag = 9912;
    textLable.text  = self.placeholder;
    textLable.textAlignment = NSTextAlignmentCenter;
    textLable.textColor = AHColor(114, 119, 165);
    [view addSubview:btn0];
    [view addSubview:btn1];
    [view addSubview:Rbtn];
    [view addSubview:textLable];
    
    UIImage *leftImgNom = [UIImage imageNamed:@"LeftNom"];
    UIImage *rightImgNom = [UIImage imageNamed:@"RightNom"];
    
    UIImage *leftImgDis = [UIImage imageNamed:@"LeftDis"];
    UIImage *rightImgDis = [UIImage imageNamed:@"RightDis"];
    
    [btn0 setImage:leftImgNom forState:UIControlStateNormal];
    [btn0 setImage:leftImgNom forState:UIControlStateHighlighted];
    [btn0 setImage:leftImgDis forState:UIControlStateDisabled];
    [btn1 setImage:rightImgNom forState:UIControlStateNormal];
    [btn1 setImage:rightImgNom forState:UIControlStateHighlighted];
    [btn1 setImage:rightImgDis forState:UIControlStateDisabled];
    
    btn0.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [Rbtn setTitle:@"完成" forState:UIControlStateNormal];
    [Rbtn setTitle:@"完成" forState:UIControlStateHighlighted];
    
    
    [Rbtn setTitleColor: AHColor(114, 119, 165) forState:UIControlStateNormal];
    [Rbtn setTitleColor: AHColor(114, 119, 165) forState:UIControlStateHighlighted];
    
    Rbtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [btn0 addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchDown];
    [btn1 addTarget:self action:@selector(DowndateAction) forControlEvents:UIControlEventTouchDown];
    [Rbtn addTarget:self action:@selector(DoAction) forControlEvents:UIControlEventTouchDown];
    
    if (self.tag==0) {
        btn1.hidden = YES;
        btn0.hidden = YES;
    }else{
        btn1.hidden = NO;
        btn0.hidden = NO;
    }
    
    [self creatNoti];
    
}
//  resignFirstResponder
- (void)updateAction{
    
    
    if ((id)[self.superview viewWithTag:(self.tag-1)] == nil ||  (id)[self.superview viewWithTag:(self.tag-1)] ==NULL) return;
    AhTextField  *tf = (id)[self.superview viewWithTag:(self.tag-1)];
    [self resignFirstResponder];
    [tf becomeFirstResponder];
}

- (void)DowndateAction{
    
    if ((id)[self.superview viewWithTag:(self.tag+1)] ==nil ||  (id)[self.superview viewWithTag:(self.tag+1)] ==NULL) return;
    AhTextField  *tf = (id)[self.superview viewWithTag:(self.tag+1)];
    [self resignFirstResponder];
    [tf becomeFirstResponder];
    
}

- (void)DoAction{
    
    [self resignFirstResponder];
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
    UIButton *btn0 = (UIButton*)[self.inputAccessoryView  viewWithTag:9910];
    UIButton *btn1 = (UIButton*)[self.inputAccessoryView  viewWithTag:9911];
    
    UITextField *TF = [self.superview viewWithTag:(self.tag-1)];
    
    if (TF==nil || TF==NULL) {  //  说明没有上一个输入框了
        
        [btn0 setEnabled:NO];
    }else{
        [btn0 setEnabled:YES];
    }
    
    UITextField *TF2 = [self.superview viewWithTag:(self.tag+1)];
    
    if (TF2==nil || TF2==NULL) {  //  说明没有下一个输入框了
        
        [btn1 setEnabled:NO];
        
    }else{
        [btn1 setEnabled:YES];
        
    }
}

#pragma mark -键盘隐藏
-(void)keyboardWillHidden
{
    UIButton *btn0 = (UIButton*)[self.inputAccessoryView  viewWithTag:9910];
    UIButton *btn1 = (UIButton*)[self.inputAccessoryView  viewWithTag:9911];
    
    [btn0 setEnabled:YES];
    [btn1 setEnabled:YES];
    
}

@end
