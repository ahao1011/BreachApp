//
//  AhTabBar.m
//  xinlang
//
//  Created by ah on 15/10/2.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "AhTabBar.h"
#import "UIImage+Ah.h"
#import "AhTabBarButton.h"

@interface AhTabBar ()

@property (nonatomic,weak) AhTabBarButton *selectedBtn;
@property (nonatomic,weak) UIButton *plusButton;
@property (nonatomic ,strong)NSMutableArray *tabbarButtons;//tabbarButton的4个按钮的承载数组

@end

@implementation AhTabBar
// 懒加载
- (NSMutableArray *)tabbarButtons{
    
    if (!_tabbarButtons) {
        _tabbarButtons = [[NSMutableArray alloc]init];
    }
    return _tabbarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { // 非iOS7下设置tabBar的背景
        if(!iOS7){
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        }
    }
    return self;
}


- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    // 创建按钮
    AhTabBarButton *button = [[AhTabBarButton alloc]init];
    [self addSubview:button];
    // 设置数据
    button.item = item;
    // 设置点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    // 添加按钮到数组
    [self.tabbarButtons addObject:button];
    // 设置默认选中按钮
    if (self.tabbarButtons.count==1) {
        [self buttonClick:button];
    }
    
    
}
/**
 *  button点击事件
 */
- (void)buttonClick:(AhTabBarButton*)button{
    // 通知代理
    
//    MYLog(@"%zd===%zd",self.selectedBtn.tag,button.tag);
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        
        if ([self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedBtn.tag to:(int)button.tag]) {
            
            self.selectedBtn.selected = NO;
            button.selected = YES;
            self.selectedBtn = button;
        }
    }
    // 设置按钮状态
   
    
    
}
/**
 *  添加子控件
 */
- (void)layoutSubviews{
    
    [super layoutSubviews];
    // 按钮的frame数据 ***********//
    CGFloat btnY =0;
    CGFloat btnW =self.frame.size.width/self.subviews.count;
    CGFloat btnH =self.frame.size.height;
    
    for (int index = 0; index<self.subviews.count; index++) {
        AhTabBarButton *button = self.subviews[index];
        CGFloat btnX= index*btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        // 绑定tag
        button.tag = index;
    }
}
@end
