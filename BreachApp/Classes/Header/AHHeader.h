//
//  AHHeader.h
//  BannNewVersion
//
//  Created by ah on 16/3/25.
//  Copyright © 2016年 ah. All rights reserved.
//

// 常见公共类以及宏

#ifndef AHHeader_h
#define AHHeader_h

#import "UIColor+Hex.h"
#import "UIColor+Extension.h"
#import "UIView+AhExtion.h"
#import "UIView+Extension.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "NetManager.h"
#import "AhAlertView.h"




#define _IPHONE80_ 80000    //  ios8
// 1.ios
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
// 2.获得RGB颜色
#define AHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//3. 随机色
#define AHRandomColor AHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//4. 屏幕宽 高
#define K_Screen_Width [UIScreen mainScreen].bounds.size.width
#define K_Screen_Height [UIScreen mainScreen].bounds.size.height

//5. 设备简单判断

#define Iphone4 ((K_Screen_Width == 320) && (K_Screen_Height == 480))
#define Iphone5 ((K_Screen_Width == 320) && (K_Screen_Height == 568))
#define Iphone6 ((K_Screen_Width == 375) && (K_Screen_Height == 667))
#define Iphone6P ((K_Screen_Width == 414) && (K_Screen_Height == 736))

//6. 字体
#define AhFont(x)  [UIFont systemFontOfSize:x]
// 7.UIApplication
#define AhApplication  [UIApplication sharedApplication]
// 8. 通知中心
#define AhCenter [NSNotificationCenter defaultCenter]
// 9. app主窗口
#define AhKeyWindow [UIApplication sharedApplication].keyWindow
// 10 偏好设置  持久化
#define AhUserDefault [NSUserDefaults standardUserDefaults]




#ifdef DEBUG  // 调试阶段
#define MYLog(...) NSLog(__VA_ARGS__)
#else // 发布阶段
#define MYLog(...)
#endif



#endif /* AHHeader_h */
