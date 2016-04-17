//
//  UIView+AhExtion.h
//  Hd_JSHT
//
//  Created by ah on 16/1/22.
//  Copyright © 2016年 ah. All rights reserved.
//

/**
 *  1. 模糊化处理需要添加依赖库 Accelerate.Framework
 */

#import <UIKit/UIKit.h>

@interface UIView (AhExtion)

/**截图*/
-(UIImage *)convertViewToImage;

/**模糊化1_iOS8苹果自带的毛玻璃效果*/
- (void)MakeEffectOFFrostedGlassr;

@end
