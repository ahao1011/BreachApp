//
//  NetManager.h
//  BreachApp
//
//  Created by ah on 16/4/11.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AhResult.h"
#import "AhRequest.h"


/**url公共头*/
//static NSString * const HOST = @"https://mpay.tebill.com:8090/RMobPay/";  // 正式
/**url公共头*/
static NSString * const HOST = @"https://mpay.tebill.com:8090/RMobPay/";  // 测试
/**url公共尾*/
static NSString * const SUFFIX = @".xml";


typedef NSURLSessionTask AhSessionTask;

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
 *  设置是否打印调测信息  默认为YES
 */
+ (void)setDebug:(BOOL)debug;
/**
 *  @author Ah, 16-04-15 11:04:22
 *
 *  get的异步请求
 */
+ (AhSessionTask*)GET:(NSString *)URLString
 parameters:(AhRequest*)Request
             progress:(void (^)(int64_t bytesRead,
                                int64_t totalBytesRead))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**post的异步请求*/
+(AhSessionTask*)POST:(NSString *)URLString
 parameters:(AhRequest*)Request
             progress:(void (^)(int64_t bytesRead,
                                int64_t totalBytesRead))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure ;
/**
 *  下载文件
 *
 *  @param URLString  下载路径
 *  @param SaveToPath 保存路径
 *  @param Progress   进度描述
 *  @param success    成功句柄
 *  @param failure    失败句柄
 */
+ (AhSessionTask *)downloadWithUrl:(NSString *)URLString
                        saveToPath:(NSString *)SaveToPath
                          progress:(void (^)(int64_t bytesRead,
                                             int64_t totalBytesRead))Progress
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;
/**
 *  取消网络请求的3种方法
 // 取消全部请求
 [HYBNetworking cancelAllRequest];
 
 // 取消单个请求方法一
 [HYBNetworking cancelRequestWithURL:path];
 
 // 取消单个请求方法二
 [task cancel];
 */

/**
 *  取消全部请求
 */
+ (void)cancelAllRequest;
/**
 *  取消特定请求
 *
 *  @param url url路径
 */
+ (void)cancelRequestWithURL:(NSString *)url ;

@end
