//
//  UIImage+AhExtion.h
//  tefubao
//
//  Created by ah on 15/12/1.
//  Copyright © 2015年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AhExtion)

#pragma mark -  基础功能

+ (UIImage *)imageWithName:(NSString *)name;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizeImageWithName:(NSString *)name;
/**
 *  返回一张自由拉伸的图片(保护区域自定义)
 */
+ (UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
#pragma mark -  图片颜色相关
/**
 *  以颜色生成一直张图片
 */
- (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  区图片某一个点 的颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;
/** 调用这个默认图片 */
- (UIColor *)colorDefault;
/** 若和银行色标不对 left可以微调 */
- (UIColor *)colorFloat:(float)left;

/** 背景模糊化实现 */

/**
 *
 * 1.白色,参数:
 透明度 0~1,  0为白,   1为深灰色
 半径:默认30,推荐值 3   半径值越大越模糊 ,值越小越清楚
 色彩饱和度(浓度)因子:  0是黑白灰, 9是浓彩色, 1是原色  默认1.8
 “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。 */
- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;
- (UIImage *)imgWithBlur;




@end
