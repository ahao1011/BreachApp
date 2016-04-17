//
//  UIBarButtonItem+Ah.h
//  xinlang
//
//  Created by ah on 15/10/10.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Ah);

/**
 *  设置文字标题
 *
 *  @param title  标题
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target  action:(SEL)action;
/**
 *  添加一个UIBarButtonItem  (正常 高亮状态的图片修改)
 *  @param icon     noamil下的图片名字
 *  @param highIcon 高亮状态下图名字
 *  @param selIcon  选定状态相爱
 *  @param target   targert
 *  @param action   SEL方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target  action:(SEL)action;

/**
 *  添加一个UIBarButtonItem  (正常 选定状态的图片修改)
 *  @param icon     noamil下的图片名字
 *  @param selIcon  选定状态相爱
 *  @param target   targert
 *  @param action   SEL方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon sleIcon:(NSString *)selIcon target:(id)target  action:(SEL)action;
/**
 *  添加一个UIBarButtonItem  (正常 高亮 选定状态的图片修改)
 *  @param icon     noamil下的图片名字
 *  @param highIcon 高亮状态下图名字
 *  @param selIcon  选定状态相爱
 *  @param target   targert
 *  @param action   SEL方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon sleIcon:(NSString *)selIcon target:(id)target  action:(SEL)action;
/** 位置调节的填充物 */
+ (UIBarButtonItem *)itemWithspace:(float)padding;
/** 自定义一个左按钮 */
+ (NSArray *)itemWithCustomBackItemWithSpace:(CGFloat)padding icon:(NSString *)icon target:(id)target  action:(SEL)action;



@end

