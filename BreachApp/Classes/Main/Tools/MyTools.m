//
//  MyTools.m
// 
//
//  Created by ah on 15/9/20.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "MyTools.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <sys/sysctl.h>
#import "sys/utsname.h"
#import "LocalAuthentication/LAContext.h"
#import <LocalAuthentication/LocalAuthentication.h>



@interface MyTools ()



@end

@implementation MyTools




-(void)setTouchIDEnabled:(BOOL)TouchIDEnabled{
    
    
}

/**
 *  单例化 arc下的建立套路 非Arc下还需要考虑到copy retain autoreleass 
 */
+ (instancetype)defaultTool{
    
    static MyTools *mt = nil;
    // 线程锁
    @synchronized (self){
        
        if (!mt) {
            mt = [[self alloc]init];
        }
    }
    return mt;
}


+ (instancetype) allocWithZone:(struct _NSZone *)zone

{
    
    return [self defaultTool];
    
}

#pragma mark -  基础功能

// 文字宽度
+ (CGSize)AH_sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
// 简单的二维码图片
+ (UIImage *)AH_QRCodeWithString:(NSString *) string
{
    //创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //CIFilter *filter = [CIFilter filterWithName:kCIAttributeDefault];
    //初始化(已有的值不变)
    [filter setDefaults];
    
    // 渲染并输出
    // 输入的文字渲染
    [filter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    
    
    //  饱和度      0---2
    // [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputSaturation"];
    //  亮度  10   -1---1
    // [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputBrightness"];
    //  对比度 -11  0---4
    //[filter setValue:[NSNumber numberWithFloat:2] forKey:@"inputContrast"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    // 创建CIImage语柄
    CGImageRef cgimage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    //转换图片
    UIImage *image = [UIImage imageWithCGImage:cgimage scale:0.1 orientation:UIImageOrientationUp];
    NSLog(@"image:%@",image);
    // 不失真放大
    UIImage *resized = [self AH_resizeImage:image withQuality:kCGInterpolationNone rate:5.0];
    return resized;
    
}

+ (UIImage *)AH_resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate
{
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}
/**
 *  图片旋转
 *
 *  @param image       要旋转的图片
 *  @param orientation 角度
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

/**
 *  图片不失真的拉伸
 */
+ (UIImage *)AH_resizableImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10, 10)  resizingMode:UIImageResizingModeStretch];
}

+ (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize andFilledTextString:(NSString *)str {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = str;
    [label sizeToFit];
    CGSize size = label.bounds.size;
    
    return size;
}
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    // 图片压缩
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+ (UIImage *) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    // 裁剪成圆
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
/**
 *  检测某字典里是否含有某key'值
 *
 *  @param dictionary 字典
 *  @param key        key值
 *
 *  @return BOOL值
 */
+ (BOOL)CheckADic:(NSDictionary *)dictionary HaveTheKey:(NSString *)key{
    
    if([[dictionary allKeys] containsObject:key]){
        return YES;
    }
    return NO;
}

/**
 *  根据label的字体和文字内容获取label宽度
 */
-(CGFloat)getLabelWidthWithLabel:(UILabel*)label
{
    NSDictionary *attribute = @{NSFontAttributeName: label.font};
    CGSize retSize = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.font.lineHeight)
                                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute
                                              context:nil].size;
    return retSize.width;
}

#pragma mark -  缓存
//
// 写数据
+ (void)writeToLocal:(NSData *)data WithPathName:(NSString*)PathName{
    
    NSString *path = [NSHomeDirectory()stringByAppendingPathComponent:PathName];
    [data writeToFile:path atomically:YES];
    
}
//读数据
+ (NSData *)readLocalFromPathName:(NSString*)PathName{
    
//    NSString *path = [NSHomeDirectory()stringByAppendingFormat:@"/Documents/%@.text",NSStringFromClass([self class])];
    
    NSString *path = [NSHomeDirectory()stringByAppendingPathComponent:PathName];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        return [NSData dataWithContentsOfFile:path];
    }
#if DEBUG
    NSLog(@"路劲=%@未找到,或者路径内无数据",path);
#else
    
#endif
    return nil;
    
}

#pragma mark -  获取设备型号和系统版本

+ (NSString *)getSystemVersion{
    
    return [[UIDevice currentDevice] systemVersion]; //手机系统版本
}

+ (NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine",NULL, &size, NULL,0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size,NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    //NSString *platform = [NSStringstringWithUTF8String:machine];二者等效
    NSLog(@"platform===%@",platform);
    free(machine);
    return platform;
}

+ (NSString *)getPlatformString
{
    NSString *platform = [self getDeviceVersion];
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    //iPot Touch
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad air 2";
    
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad air 2";
    
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
    
}

+ (BOOL)IsIphone6Or6S{
    
    NSString *device = [self getPlatformString];
    NSRange rang = [device rangeOfString:@"6"];
    return rang.length>0?YES:NO;
}

+(IphoneDeviceType)getIponeTypeFromPlatform{
    NSString *platform = [self getDeviceVersion];
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return iphone4Less;//@"iPhone 1";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return iphone4Less;//@"iPhone 3";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return iphone4Less;//@"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return iphone4Ors;//iphone4;
    
    if ([platform isEqualToString:@"iPhone3,2"]) return iphone4Ors;//iphone4;
    
    if ([platform isEqualToString:@"iPhone3,3"]) return iphone4Ors;//iphone4;
    
    if ([platform isEqualToString:@"iPhone4,1"]) return iphone4Ors;//iphone4s;
    
    if ([platform isEqualToString:@"iPhone5,1"]) return iphone5OrsOrc;//iphone5;
    
    if ([platform isEqualToString:@"iPhone5,2"]) return iphone5OrsOrc;//iphone5;
    
    if ([platform isEqualToString:@"iPhone5,3"]) return iphone5OrsOrc;//iphone5c;
    
    if ([platform isEqualToString:@"iPhone5,4"]) return iphone5OrsOrc;//iphone5c;
    
    if ([platform isEqualToString:@"iPhone6,1"]) return iphone5OrsOrc;//iphone5s;
    
    if ([platform isEqualToString:@"iPhone6,2"]) return iphone5OrsOrc;//iphone5s;
    
    if ([platform isEqualToString:@"iPhone7,1"]) return iphone6Ors;//iphone6;
    
    if ([platform isEqualToString:@"iPhone7,2"]) return iphone6plusOrs;//iphone6plus;
    
    if ([platform isEqualToString:@"iPhone8,1"]) return iphone6Ors;//@"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return iphone6plusOrs;//@"iPhone 6s Plus";
    
    return isNotIphone;
}


//- (void)text{

    /*
    
     - (NSInteger)integerForKey:(NSString *)defaultName;
     - (float)floatForKey:(NSString *)defaultName;
     - (double)doubleForKey:(NSString *)defaultName;
     - (BOOL)boolForKey:(NSString *)defaultName;
     - (nullable NSURL *)URLForKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);
     
     - (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
     - (void)setFloat:(float)value forKey:(NSString *)defaultName;
     - (void)setDouble:(double)value forKey:(NSString *)defaultName;
     - (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
     - (void)setURL:(nullable NSURL *)url forKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);*/
//}

+ (BOOL)isHaveTheKey:(NSString *)key{
    
    
   return [[NSUserDefaults standardUserDefaults] objectIsForcedForKey:key];
    
}

+ (void)SetAObject:(id)value forAKey:(NSString *)key{
    
   
    if (value == nil) {
        NSLog(@"%@对应的Value为nil",key);
        return;
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:value forKey:key];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (id)ObjectForAKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+ (NSString *)stringForAKey:(NSString *)key{
    
    return (NSString *)[self ObjectForAKey:key];
}

+ (NSDictionary *)DictionaryForAKey:(NSString *)key{
    
    return (NSDictionary *)[self ObjectForAKey:key];
}

+ (NSData *)dataForAkey:(NSString *)key{
    
    return (NSData *)[self ObjectForAKey:key];
}

+ (NSArray *)arrayForAKey:(NSString *)key{
    
    return (NSArray *)[self ObjectForAKey:key];
}

+ (void)SetBool:(BOOL)Value ForAKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults]setBool:Value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+ (BOOL)BoolForAKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:key];
}
/**
 *  检测Touch ID 是否开启
 */
+ (BOOL)TouchIDEnable{
    
    return [self BoolForAKey:TouchID];
    
}
/**设置Touch ID 功能开启和关闭*/
+ (void)setTouchIDEnable:(BOOL)value{
    
    [self SetBool:value ForAKey:TouchID];
}
/**
 *  touchID功能
 *
 *  @param Success                成功后Block
 *  @param PutPwd                 选择输入密码的Block
 *  @param localizedFallbackTitle 定制的Title
 */
+ (void)CheckTouchIDsuccess:(void(^)())Success  PutPwd:(void(^)())PutPwd localizedFallbackTitle:(NSString *)localizedFallbackTitle {
    
    LAContext *myContext = [[LAContext alloc] init];
    if (localizedFallbackTitle!=nil) {
         myContext.localizedFallbackTitle =localizedFallbackTitle;
    }else{
         myContext.localizedFallbackTitle = @"";
    }
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"通过Home键验证已有手机指纹";
//    __block  NSString *msg;
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
         
                  localizedReason:myLocalizedReasonString
         
                            reply:^(BOOL success, NSError *error) {
                                
                                if (success) {
                                    MYLog(@"验证成功");
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (Success!=nil) {
                                            Success();
                                        }
                                    });
                                    
                                } else {
                                    MYLog(@"验证失败");
                                    
                                    MYLog(@"error====%@",error.localizedDescription);
                                    //  Application retry limit exceeded. 系统取消
                                    
                                    if ([error.localizedDescription isEqualToString:@"Fallback authentication mechanism selected."]) {
                                        
                                        
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                           [MBProgressHUD showError:@"nimeia"];
                                            
                                        });
                                        
                                    }
                                    
                                    switch (error.code) {
                                        case LAErrorSystemCancel:
                                        {
                                            MYLog(@"系统取消验证Touch ID");
                                            [MBProgressHUD showError:@"指纹不匹配"];
                                            break;
                                        }
                                        case LAErrorUserCancel:
                                        {
                                            MYLog(@"用户取消验证Touch ID");
                                            
                                            break;
                                        }
                                        case LAErrorUserFallback:
                                        {
                                            MYLog(@"用户选择输入密码");
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                
                                                if (PutPwd!=nil) {
                                                    PutPwd();
                                                }

                                                
                                            });
                                            break;
                                        }
                                        default:
                                        {
                                            break;
                                        }
                                    }
                                    
                                }
                              
                                
                            }];
        
    } else {
        switch (authError.code) {
            case LAErrorTouchIDNotEnrolled:
            {
//                [AhAlertView alertViewWithTitle:@"提示" message:@"该设备未录入指纹,暂不支持Touch ID功能"];
                break;
            }
            case LAErrorPasscodeNotSet:
            {
//               [AhAlertView alertViewWithTitle:@"提示" message:@"系统未设置密码"];
                break;
            }
            default:
            {
//                [AhAlertView alertViewWithTitle:@"提示" message:@"该设备暂不支持Touch ID功能"];
                break;
            }
        }
    }
}

#pragma mark -  GCD功能
/**
 *  app运行期间只运行一次
 *
 *  @param Handle 运行一次的Handle
 */
+ (void)ActionOnceWithGCD:(void(^)(void))Handle{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Handle();
    });
}







@end
