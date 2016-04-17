//
//  NetManager.h
//  BreachApp
//
//  Created by ah on 16/4/11.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <Foundation/Foundation.h>

/**url公共头*/
//static NSString * const HOST = @"https://mpay.tebill.com:8090/RMobPay/";  // 正式
/**url公共头*/
static NSString * const HOST = @"https://mpay.tebill.com:8090/RMobPay/";  // 测试
/**url公共尾*/
static NSString * const SUFFIX = @".xml";

@interface NetManager : NSObject


/**
 *  设置公共请求头
 *  @author Ah, 16-04-15 11:04:33
 */
+ (void)setCommonHeader:(NSDictionary*)headers;
/**
 *  @author Ah, 16-04-15 12:04:51
 *
 *  设置最大并发数,设置过大容易出错 最大设置到9
 */
+ (void)setMaxConcurrentOperationCount:(NSInteger)maxCount;
/**
 *  @author Ah, 16-04-15 11:04:22
 *
 *  get的异步请求
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress * downloadProgress))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**post的异步请求*/
+(void)POST:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *currentProgress))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end
