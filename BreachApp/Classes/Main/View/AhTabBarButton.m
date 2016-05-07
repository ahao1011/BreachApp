//
//  AhTabBarButton.m
//  xinlang
//
//  Created by ah on 15/10/8.
//  Copyright (c) 2015年 ah. All rights reserved.
//

// 图片占button得高度比例
#define AhTabBarButtonImageRatio 0.6
#define AhTabBarButtonTitleColor  AHColor(101, 102, 103)
#define AhTabBarButtonTitleSelectedColor K_AppColor

#import "AhTabBarButton.h"
#import "UIImage+Ah.h"
#import "AhBadgeButton.h"

@interface AhTabBarButton ()
/**
 *  提醒数字
 */
@property (nonatomic,weak) AhBadgeButton *badgeButton;

@end

@implementation AhTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = K_TabBarColor;
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self setTitleColor:AhTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:AhTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageNamed:@"tabbar_background"] forState:UIControlStateSelected];
        }
        // 添加提醒数字按钮
        AhBadgeButton *badgeButton = [[AhBadgeButton alloc]init];
        // 设置拉伸模式  自动适配
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        self.badgeButton.hidden = NO;
    }
    return self;
}
#pragma mark -- 内部空间frame重写
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW =contentRect.size.width;
    CGFloat imageH =contentRect.size.height*AhTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW =contentRect.size.width;;
    CGFloat titleH =contentRect.size.height*(1-AhTabBarButtonImageRatio);
    CGFloat titleY =contentRect.size.height*AhTabBarButtonImageRatio;
    return CGRectMake(0, titleY, titleW, titleH);
}
/**
 *  设置button内部title和图片属性
 */
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    // kvo 监听属性改变(有添加就有删除 )
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
// 这个要特别的注意
- (void)dealloc{
    
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    
    
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    // 设置数据
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX=self.frame.size.width-self.badgeButton.frame.size.width-5;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
    
}
/**
 *  通过重写 取消高亮状态的显示
 */
- (void)setHighlighted:(BOOL)highlighted{
    
}
@end
