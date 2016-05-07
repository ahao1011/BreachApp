//
//  UIButton+Extension.h
//  HBDSBank
//
//  Created by ah on 16/3/3.
//  Copyright © 2016年 Administrator.Fyxrhyry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)


/**button文字下加下划线*/
- (void)setStyleSingleLine:(NSString*)linestr;

/**设置文字*/
- (void)setATitle:(NSString *)title;
/** 设置颜色 */
- (void)setATitleColor:(UIColor *)titleColor;
/** 设置图片 */
- (void)setAImage:(UIImage*)img;
/** 设置背景图片 */
- (void)setABackImage:(UIImage*)backImg;

@end
