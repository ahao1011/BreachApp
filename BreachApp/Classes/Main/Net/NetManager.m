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





#import "NetManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MJExtension.h"

/**
 *  公共请求头
 */
static NSDictionary *Ah_httpHeaders = nil;
/**是否打开调试开关*/
static BOOL Debug = NO;
/**接受宿友SessionTask的数组*/
static NSMutableArray *TaskArr;


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
/**设置是否打印调试信息*/
+ (void)setDebug:(BOOL)debug{
    
    Debug = debug;
}
#pragma mark- get
/**GEt*/
+ (AhSessionTask*)GET:(NSString *)URLString
 parameters:(AhRequest*)Request
             progress:(void (^)(int64_t bytesRead,
                                int64_t totalBytesRead))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [self defautManager];
    URLString = [self MakeFullUrl:URLString];
    NSDictionary *parameters = Request.mj_keyValues;
    if (Debug) {  //  打开打印
        MJExtensionLog(@" 🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹 \n 请求模型:%@\n 参数为:\n %@ \n",[NSString stringWithUTF8String:class_getName(Request.class)],parameters);
    }
    AhSessionTask *task =  [mgr GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (Progress) {
            
            Progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *resultClassName = [self resultFromRequest:Request];
            Class aclass = NSClassFromString(resultClassName);
            AhResult *result = [aclass mj_objectWithKeyValues:dict];
            if (Debug) {  //  打开打印
                MJExtensionLog(@" 🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹 \n 接受模型:%@\n 接受数据为:\n %@ \n",resultClassName,result);
            }
            success(result);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (Debug) {  //  打开打印
                MJExtensionLog(@"否❌否❌否❌否❌否❌否❌否❌否❌否❌ \n 数据请求失败 \n: 请求雷明:%@\n 接受数据为:\n %@ \n",[NSString stringWithUTF8String:class_getName(Request.class)],error);
            }
            failure(error);
        }
        [error localizedDescription];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    if (task) {
        [[self allTasks]addObject:task];
    }
    return task;
}
#pragma mark- post
+(AhSessionTask*)POST:(NSString *)URLString
 parameters:(AhRequest*)Request
             progress:(void (^)(int64_t bytesRead,
                                 int64_t totalBytesRead))Progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *mgr = [self defautManager];
    URLString = [self MakeFullUrl:URLString];
     NSDictionary *parameters = Request.mj_keyValues;
    AhSessionTask *task =  [mgr POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        if (success) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *resultClassName = [self resultFromRequest:Request];
            Class aclass = NSClassFromString(resultClassName);
            AhResult *result = [aclass mj_objectWithKeyValues:dict];
            success(result);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [error localizedDescription];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    if (task) {
        [[self allTasks]addObject:task];
    }
    return task;
}
#pragma mark- 下载文件

+ (AhSessionTask *)downloadWithUrl:(NSString *)URLString
                            saveToPath:(NSString *)SaveToPath
                          progress:(void (^)(int64_t bytesRead,
                                             int64_t totalBytesRead))Progress
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure{
    
    
    AFHTTPSessionManager *mgr = [self defautManager];
    URLString = [self MakeFullUrl:URLString];
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    AhSessionTask *task = [mgr downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (Progress) {
            Progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL URLWithString:SaveToPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allTasks] removeObject:task];
        
        if (error == nil) {
            if (success) {
                success(filePath.absoluteString);
            }
            
            if (Debug) {
                
                MYLog(@"下载成功 路径 %@",
                          [self absoluteUrlWithPath:URLString]);
            }
        } else {
            
            failure(error);
            
            if (Debug) {
                MYLog(@"下载失败 路径 %@, reason : %@",
                          [self absoluteUrlWithPath:URLString],
                          [error description]);
            }
        }
    }];
    
    [task resume];  //  断点续传 校验
    
    if (task) {
        [[self allTasks]addObject:task];
    }
    return task;
}

#pragma mark- 默认管理者

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

#pragma mark- 合成URl
/**合成Url*/
+ (NSString*)MakeFullUrl:(NSString*)url{
    
   return  [self AhURLEncode:[NSString stringWithFormat:@"%@%@%@",HOST,url,SUFFIX]];

}

#pragma mark- 由请求模型得到接受模型
/**由请求模型得到接受类模型的字符串*/
+ (NSString *)resultFromRequest:(AhRequest*)request{
    
    NSString *requestClassName =  [NSString stringWithUTF8String:class_getName(request.class)];
    NSString *resultClassName = [NSString stringWithFormat:@"%@Res",requestClassName];
    return resultClassName;
}

#pragma mark- 请求url含有中文的处理

/**url含有中文时的处理*/
+ (NSString *)AhURLEncode:(NSString *)url {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    
    return url;
}

#pragma mark- 获取所有请求SessionTask的数组单例
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (TaskArr == nil) {
            TaskArr = [[NSMutableArray alloc] init];
        }
    });
    
    return TaskArr;
}
#pragma mark- 完整路径描述
+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        MYLog(@"传入的path为空");
        return @"";
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {  //  猜测path是一个片段
        absoluteUrl = [self MakeFullUrl:path];
    }
    return absoluteUrl;
}




@end
