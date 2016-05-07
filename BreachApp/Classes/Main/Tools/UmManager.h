//
//  UmManager.h
//  BreachApp
//
//  Created by ah on 16/4/26.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

typedef enum {  // 弃用
   Sina,
    QQ,
    We
}ShareType;

@interface UmManager : NSObject

/**返回App时的操作*/
+ (BOOL)UMOpenUrl:(NSURL *)url Completion:(void(^)())compleTion ;

/**打开调试开关*/
+ (void)openDebug:(BOOL)Debug;

+ (instancetype)defaultManager;
/**设置基本信息*/
- (void)setUmInfo;

#pragma mark- 三方登录

/**
 *  QQ三方登录
 */
- (void)LoginQQWithvc:(UIViewController *)vc completion:(void(^)(NSString * userName ,NSString * iconUrl ,NSString * token,NSString * usid))completion;
/**
 *  微信三方登录
 */
- (void)LoginWXWithvc:(UIViewController *)vc completion:(void(^)(NSString * userName ,NSString * iconUrl ,NSString * token,NSString * usid))completion;


#pragma mark- 三方分享
/**
 *  自定义列表分享
 *
 *  @param types               需要分享的平台数组
 *  @param titleMessage        标题
 *  @param img                 图片
 *  @param location            位置
 *  @param urlResource         url字符串
 *  @param presentedController self
 *  @param completion          分享完成后回调
 */
- (void)ShareSNSToTypes:(NSArray *)types withtitle:(NSString*)title titleMessage:(NSString *)titleMessage img:(UIImage*)img location:(CLLocation *)location urlResource:(NSString *)url
    presentedController:(UIViewController *)presentedController
             completion:(void (^)(NSString * responseName ,BOOL isShareSuccess))completion;

@end
