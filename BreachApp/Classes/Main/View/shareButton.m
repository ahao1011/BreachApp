//
//  shareButton.m
//  BabyDemo
//
//  Created by ah on 15/10/21.
//  Copyright (c) 2015年 ah. All rights reserved.
//


// 图片占button得高度比例
#define AhTabBarButtonImageRatio 0.75
#import "shareButton.h"

@implementation shareButton


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
    
    self.imageView.contentMode = UIViewContentModeBottom;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * AhTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleY = contentRect.size.height*AhTabBarButtonImageRatio;
    CGFloat titleH = contentRect.size.height-titleY;
    CGFloat titleW = contentRect.size.width;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted{
    
    
}

@end
