//
//  UIView+AhExtion.m
//  Hd_JSHT
//
//  Created by ah on 16/1/22.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "UIView+AhExtion.h"



@implementation UIView (AhExtion)

/**截图*/
-(UIImage *)convertViewToImage

{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

//用iOS8新出的功能。特别方便，还能支持实时模糊，缺点就是只能iOS8以上使用

//
/**模糊化1_iOS8苹果自带的毛玻璃效果*/

- (void)MakeEffectOFFrostedGlassr {
    
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
    
    view.frame = self.bounds;
    
    [self addSubview:view];
    
    
}




@end
