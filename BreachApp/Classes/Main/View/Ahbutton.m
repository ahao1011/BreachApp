//
//  Ahbutton.m
//  BreachApp
//
//  Created by ah on 16/4/25.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "Ahbutton.h"

@implementation Ahbutton


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    
    self.layer.cornerRadius = 8.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = K_AppColor;
    
    [self setATitleColor:[UIColor whiteColor]];
}
@end
