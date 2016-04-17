
//
//  MyTools.h
// 
//
//  Created by ah on 15/9/20.
//  Copyright (c) 2015年 ah. All rights reserved.

//MyTools 是一个集成的常用工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IphoneDeviceType)
{
    iphone4Less  = 0,//iphone4以下
    iphone4Ors,      //iphone4和iphone4s
    iphone5OrsOrc,   //iphone5和iphone5s和iphone5c
    iphone6Ors,      //iphone6和iphone6s
    iphone6plusOrs,  //iphone6plus和iphone6splus
    isNotIphone
};

/**touchid的key*/
static NSString *const TouchID = @"TouchID";
static NSString *const  Name = @"name";
static NSString *const  UserId = @"UserId";

@interface MyTools : NSObject

#pragma mark -  基础功能

+ (instancetype)defaultTool;

/**
 *  计算lable的size 宽高
 *
 *  @param text    需要计算的lable.text
 *  @param font    lable.font
 *  @param maxSize lable框的范围 CGSizeMake();
 *
 *  @return 宽高的size
 */
+ (CGSize)AH_sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  输出简单的二维码图片
 *
 *  @param string 图片承载信息
 *
 *  @return 二维码图片 不是真放大
 */
+ (UIImage *)AH_QRCodeWithString:(NSString *) string;
/**
 *  图片的拉伸
 *
 *  @param name 要拉伸的图片名称
 *
 *  @return 拉伸后的图片
 */
+(UIImage *)AH_resizableImage:(NSString *)name;
/**
 *  计算一段lable文字的size
 */
+ (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize andFilledTextString:(NSString *)str;

/**
 *  裁剪成圆
 */
+ (UIImage *) circleImage:(UIImage*) image withParam:(CGFloat) inset;

/**
 *  压缩图片
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
/**
 *  判断某字典中是否含有某Key
 */
+ (BOOL)CheckADic:(NSDictionary *)dictionary HaveTheKey:(NSString *)key;
/**
 *  根据label的字体和文字内容获取label宽度
 */
-(CGFloat)getLabelWidthWithLabel:(UILabel*)label;
/**
 *  图片旋转
 *
 *  @param image       要旋转的图片
 *  @param orientation 角度
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

#pragma mark -  缓存

+ (void)writeToLocal:(NSData *)data WithPathName:(NSString*)PathName;
+ (NSData *)readLocalFromPathName:(NSString*)PathName;


#pragma mark -  获取设备型号和系统版本

/**获取手机系统版本*/
+ (NSString *)getSystemVersion;
/**获取设备号*/
+ (NSString*)getDeviceVersion;
/**获取设备名称*/
+ (NSString *)getPlatformString;
/**获取iphone设备型号*/
+(IphoneDeviceType)getIponeTypeFromPlatform;
/**
 *  判断是否是6 或者 6s (含p) 一般用在TouchId或者Touch 3D的判断中 */
+ (BOOL)IsIphone6Or6S;



#pragma mark -  NSUserDefaults (缓存,用于轻量级)

/**判断某key是否存在*/
+ (BOOL)isHaveTheKey:(NSString *)key;

+ (void)SetAObject:(id)value forAKey:(NSString *)key;

+ (id)ObjectForAKey:(NSString *)key;

+ (NSString *)stringForAKey:(NSString *)key;

+ (NSDictionary *)DictionaryForAKey:(NSString *)key;

+ (NSData *)dataForAkey:(NSString *)key;

+ (NSArray *)arrayForAKey:(NSString *)key;

+ (void)SetBool:(BOOL)Value ForAKey:(NSString *)key;

+ (BOOL)BoolForAKey:(NSString *)key;



#pragma mark -  Touch ID 功能

+ (BOOL)TouchIDEnable;

+ (void)setTouchIDEnable:(BOOL)value;

+ (void)CheckTouchIDsuccess:(void(^)())Success PutPwd:(void(^)())PutPwd localizedFallbackTitle:(NSString *)localizedFallbackTitle;

#pragma mark -  GCD功能

/**
 *  app运行期间只运行一次
 */
+ (void)ActionOnceWithGCD:(void(^)(void))Handle;






@end
