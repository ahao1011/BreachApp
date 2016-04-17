//
//  UIButton+Extension.m
//  HBDSBank
//
//  Created by ah on 16/3/3.
//  Copyright © 2016年 Administrator.Fyxrhyry. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIColor+Hex.h"

@implementation UIButton (Extension)

- (void)setStyleSingleLine:(NSString*)linestr{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:linestr];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:strRange];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:strRange];
    [self setAttributedTitle:str forState:UIControlStateNormal];
    [self setAttributedTitle:str forState:UIControlStateHighlighted];
}


/**设置标题*/
- (void)setATitle:(NSString *)title{
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    
}
/**设置颜色*/
- (void)setATitleColor:(UIColor *)titleColor{
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];

}

@end
