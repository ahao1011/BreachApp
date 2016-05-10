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
#import "MJExtension.h"
#import "NSString+Extension.h"
#import "NSString+MJExtension.h"
#import "UIColor+Hex.h"
#import "UIColor+Extension.h"
#import "Ahbutton.h"
#import "UIBarButtonItem+Ah.h"
#import "AHNavigationController.h"
#import "AhRequest.h"
#import "AhResult.h"
#import "BraschTool.h"
#import "Ahbutton.h"
#import "NumberVerification.h"
#import "UIButton+Extension.h"
//#import "UITextField+Extion.h"
#import "TimerButton.h"





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
#define K_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define K_ScreenHeight iOS7 ? [UIScreen mainScreen].bounds.size.height :[UIScreen mainScreen].bounds.size.height-20

//5. 设备简单判断

#define Iphone4 ((K_ScreenWidth == 320) && (K_ScreenHeight == 480))
#define Iphone5 ((K_ScreenWidth == 320) && (K_ScreenHeight == 568))
#define Iphone6 ((K_ScreenWidth == 375) && (K_ScreenHeight == 667))
#define Iphone6P ((K_ScreenWidth == 414) && (K_ScreenHeight == 736))

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
//  tabbarVC

#define BreachTabBarViewController (AHTabBarViewController*)self.window.rootViewController




#ifdef DEBUG  // 调试阶段
#define MYLog(...) NSLog(__VA_ARGS__)
#else // 发布阶段
#define MYLog(...)
#endif



#endif /* AHHeader_h */
