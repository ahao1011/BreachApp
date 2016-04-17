//
//  UIBarButtonItem+Ah.m
//  xinlang
//
//  Created by ah on 15/10/10.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "UIBarButtonItem+Ah.h"

@implementation UIBarButtonItem (Ah)

/** 根方法 */
+ (UIBarButtonItem *)itemWithTitle:(NSString*)title Icon:(NSString *)icon highIcon:(NSString *)highIcon sleIcon:(NSString *)selIcon target:(id)target  action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:selIcon] forState:UIControlStateSelected];
    if (title!=nil) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    button.frame = (CGRect){CGPointZero,{40,40}};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return[[UIBarButtonItem alloc]initWithCustomView:button];
    
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target  action:(SEL)action{
    
    return [self itemWithTitle:title Icon:nil highIcon:nil sleIcon:nil target:target action:action];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon sleIcon:(NSString *)selIcon target:(id)target  action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:selIcon] forState:UIControlStateSelected];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return[[UIBarButtonItem alloc]initWithCustomView:button];
    
}



+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    
    return [self itemWithIcon:icon highIcon:highIcon sleIcon:nil target:target action:action];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon sleIcon:(NSString *)selIcon target:(id)target action:(SEL)action{
    
    return [self itemWithIcon:icon highIcon:nil sleIcon:selIcon target:target action:action];
}

+ (UIBarButtonItem *)itemWithspace:(float)padding{
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = padding;
    return space;
}

+ (NSArray *)itemWithCustomBackItemWithSpace:(CGFloat)padding icon:(NSString *)icon target:(id)target  action:(SEL)action{
    
    
    UIBarButtonItem *item = [self itemWithIcon:icon highIcon:icon sleIcon:icon target:target action:action];
    UIBarButtonItem *space = [self itemWithspace:padding];
    
    return @[space,item];   
    
}




@end
