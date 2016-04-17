//
//  UIImage+Ah.m
//  xinlang
//
//  Created by ah on 15/10/2.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "UIImage+Ah.h"

@implementation UIImage (Ah)
/**
 *  图片适配 (适配IOS7与非IOS的图片 ios7之后界面采取扁平化风格 之前不是)
 *
 *  @param name 图片名称(非IOS7的)
 *
 *  @return 图片
 */
+ (UIImage *)imageWithName:(NSString *)name{
    // iOS7  是一个宏定义 在pch文件中能用到
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];// _os7 是美工在非iOS7的图片名称基础上又加了_os7作为新名字,根据具体公司情况修改
        UIImage *image = [UIImage imageNamed:newName];
        if (image==nil) {// 可能存在一些iOS7与非iOS7公用的图片 此时没有_os7这类图片
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    //非iOS7
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizeImageWithName:(NSString *)name{
    
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*.5  topCapHeight:image.size.height*.5];
    
}

@end
