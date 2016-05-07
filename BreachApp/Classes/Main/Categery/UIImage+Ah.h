//
//  UIImage+Ah.h
//  xinlang
//
//  Created by ah on 15/10/2.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ah)

+ (UIImage *)imageWithName:(NSString *)name;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizeImageWithName:(NSString *)name;
/**
 *  图片旋转
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;


@end
