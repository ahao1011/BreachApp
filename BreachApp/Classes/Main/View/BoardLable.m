//
//  BoardLable.m
//  BreachApp
//
//  Created by ah on 16/5/5.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "BoardLable.h"

@implementation BoardLable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    self.layer.cornerRadius = 8.0f;
    self.layer.borderWidth = 0.8f;
    self.layer.borderColor = K_RedColor.CGColor;
    self.textColor = K_RedColor;
    self.adjustsFontSizeToFitWidth = YES;
}

@end
