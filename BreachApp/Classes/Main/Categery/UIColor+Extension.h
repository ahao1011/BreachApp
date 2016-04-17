//
//  UIColor+Extension.h
//  Hd_JSHT
//
//  Created by ah on 16/1/20.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  根据16进制返回颜色色标
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
