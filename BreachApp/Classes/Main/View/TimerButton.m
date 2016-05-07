//
//  TimerButton.m
//  TimerButton
//
//  Created by ah on 16/3/20.
//  Copyright © 2016年 ah. All rights reserved.
//

#define K_TimeNum  60  // 默认60 可以自己修改  不提供方法设置,(一个项目肯定一种倒计时,没必要,如需要 再声明属性 或者联系我QQ:656205255)

#import "TimerButton.h"

@interface TimerButton ()

@property (nonatomic,strong)NSTimer *timer;

@end

@implementation TimerButton{

    NSInteger _TimerNum; // 倒计时的时间长度
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configData];
    }
    return self;
}



- (void)configData{
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    _TimerNum = K_TimeNum;
    
    [self setTitleColor: AHColor(255, 78, 75) forState:UIControlStateNormal];
    [self setTitleColor: AHColor(255, 78, 75) forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.adjustsFontSizeToFitWidth = YES; //  高度自适应
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8.0f;
    self.layer.borderColor = AHColor(255, 78, 75).CGColor;
}

- (void)setBtnTitleColor:(UIColor *)BtnTitleColor{
    
    _BtnTitleColor = BtnTitleColor;
    
    [self setTitleColor:BtnTitleColor forState:UIControlStateNormal];
    [self setTitleColor:BtnTitleColor forState:UIControlStateHighlighted];
}

/**
 *   张天浩, 16-03-25 09:03
 *
 *  添加定时器
 */
- (void)addNstimer{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(NextCode) userInfo:nil repeats:YES];
    [self.timer fire];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer{
    
    if (self.timer) {
        [self.timer invalidate];
         self.timer = nil;
         self.titleLabel.text = @"获取验证码";
    }
}
- (void)NextCode{
    
    _TimerNum--;
    if (_TimerNum == 0) {
        _TimerNum = K_TimeNum;
        [self.timer setFireDate:[NSDate distantFuture]];
        [self removeTimer];
        self.userInteractionEnabled = YES;
        self.selected = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = @"获取验证码";

    }else
    {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor grayColor];  //  颜色可以根据项目更改
        self.titleLabel.text = [NSString stringWithFormat:@"重新获取(%zd)",_TimerNum];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 0, 0, 0);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return contentRect;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}





@end
