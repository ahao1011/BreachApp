//
//  NetManager.m
//  BreachApp
//
//  Created by ah on 16/4/11.
//  Copyright © 2016年 ah. All rights reserved.
//

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define BreachLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define HYBAppLog(s, ... )
#endif


/**
 *  公共请求头
 */
static NSDictionary *Ah_httpHeaders = nil;


#import "NetManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation NetManager

/**网络连接状态*/
+ (void)reach{
    
    
    /**
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        MYLog(@"%ld", (long)status);
    }];
}
/**设置公共请求头*/
+ (void)setCommonHeader:(NSDictionary *)headers{
    
    Ah_httpHeaders = headers;
}
/**设置最大并发数*/
+ (void)setMaxConcurrentOperationCount:(NSInteger)maxCount{
    
    if (maxCount>9) {
        maxCount=3;
    }
    [self defautManager].operationQueue.maxConcurrentOperationCount = maxCount;
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress * downloadProgress))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    URLString = [NSString stringWithFormat:@"%@%@%@",HOST,URLString,SUFFIX];
    //    if (iOS9) {
    //
    //    }else{
    //         URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    }
    
    [mgr GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (Progress) {
            Progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            success(dict);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [error localizedDescription];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

+(void)POST:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *currentProgress))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    URLString = [NSString stringWithFormat:@"%@%@%@",HOST,URLString,SUFFIX];
    [mgr POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            success(dict);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [error localizedDescription];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

+ (AFHTTPSessionManager *)defautManager{
    
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //  拿最原始的data数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    if (Ah_httpHeaders!=nil) {  //  使用者设置了公共请求头
        
        for (NSString *key in Ah_httpHeaders.allKeys) {
            if (Ah_httpHeaders[key]!=nil) {
                [manager.requestSerializer setValue:Ah_httpHeaders[key] forHTTPHeaderField:key];
            }
        }
        
    }
    
    //  设置可以接受的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    manager.operationQueue.maxConcurrentOperationCount = 3;
   
    
    return manager;
}


@end
