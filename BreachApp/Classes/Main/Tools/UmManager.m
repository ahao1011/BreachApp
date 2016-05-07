//
//  UmManager.m
//  BreachApp
//
//  Created by ah on 16/4/26.
//  Copyright © 2016年 ah. All rights reserved.
//


// http://dwz.cn/2hbCBD
/**回调*/
static NSString *const UMUrl = @"http://baidu.hz.letv.com/kan/alkmj?fr=v.baidu.com/";
/**友盟Key*/
static NSString *const UMKey = @"5656f0b567e58ea178001a93";
/**SSO-->QQ*/
static NSString *const UMQQAppId = @"1104919337" ;
/**SSO-->QQ*/
static NSString *const UMQQAppKey = @"9eeUUkEtVHbUAC4G" ;
/**SSO-->微信*/
static NSString *const UMWXAppId = @"wx2d632b14a1e070bf" ;
/**SSO-->微信*/
static NSString *const UMWXAppSecret = @"d4624c36b6795d1d99dcf0547af5443d" ;
/**SSO-->新浪*/
static NSString *const UMSinakey= @"1015976911" ;
/**SSO-->新浪*/
static NSString *const UMSinaSecret= @"65c597ac6a5d27681c4b79d0b90c4c81" ;






#import "UmManager.h"
#import "UMSocialQQHandler.h"  //  qq以及qq空间
#import "UMSocialSinaSSOHandler.h" // 新浪
#import "UMSocialWechatHandler.h"  // 微信



@interface NSUndoManager ()

@property (nonatomic,strong)UIViewController *vc;

@end

@implementation UmManager

+ (BOOL)UMOpenUrl:(NSURL *)url Completion:(void(^)())compleTion {
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        if (compleTion) {
            compleTion();
        }
    }
    return result;
}

+ (void)openDebug:(BOOL)Debug{
    
    [UMSocialData openLog:Debug];
}



+(instancetype)defaultManager{
    
    static UmManager *mg = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        mg = [[UmManager alloc]init];
    });
    return mg;
}

#pragma mark- 设置Um基本信息
- (void)setUmInfo{
    
    [UMSocialData setAppKey:UMKey];
    
    [UMSocialQQHandler setSupportWebView:YES];
    
    [UMSocialQQHandler setQQWithAppId:UMQQAppId
                               appKey:UMQQAppKey
                                  url:UMUrl];
    
#warning umurl需要在新浪开发者后台对应设置 
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:UMSinakey
//                                              secret:UMSinaSecret
//                                         RedirectURL:UMUrl];
    
    [UMSocialWechatHandler setWXAppId:UMWXAppId
                            appSecret:UMWXAppSecret
                                  url:UMUrl];
    
}

//UMShareToQQ  UMShareToWechatSession
#pragma mark- 第三方登录

- (void)LoginQQWithvc:(UIViewController *)vc completion:(void(^)(NSString * userName ,NSString * iconUrl ,NSString * token,NSString * usid))completion{

    [self LoginWithName:UMShareToQQ vc:vc completion:completion];

}
- (void)LoginWXWithvc:(UIViewController *)vc completion:(void(^)(NSString * userName ,NSString * iconUrl ,NSString * token,NSString * usid))completion{
    
    [self LoginWithName:UMShareToWechatSession vc:vc completion:completion];
}

- (void)LoginWithName:(NSString*)name vc:(UIViewController *)vc completion:(void(^)(NSString * userName ,NSString * iconUrl ,NSString * token,NSString * usid))completion{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:name];
    
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){

        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:name];
            
            completion(snsAccount.userName,snsAccount.iconURL,snsAccount.accessToken,snsAccount.usid);
            
        }});
}

#pragma mark- 三方分享

- (void)ShareSNSToTypes:(NSArray *)types withtitle:(NSString*)title titleMessage:(NSString *)titleMessage img:(UIImage*)img location:(CLLocation *)location urlResource:(NSString *)url
    presentedController:(UIViewController *)presentedController
             completion:(void (^)(NSString * responseName ,BOOL isShareSuccess))completion{
    
//    UMSocialUrlResource *urlResource = nil;
//    if (url!=nil) {
//        urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeVideo url:url];
//    }
    
    
    if ([types.lastObject isEqualToString:UMShareToQQ]) {
        
        [UMSocialData defaultData].extConfig.qqData.title = title;
        [UMSocialData defaultData].extConfig.qqData.url = url;

    }else if ([types.lastObject isEqualToString:UMShareToQzone]){
        [UMSocialData defaultData].extConfig.qzoneData.title = title;
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
    }else if ([types.lastObject isEqualToString:UMShareToWechatSession ]){
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    }else if ([types.lastObject isEqualToString:UMShareToWechatTimeline ]){
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    }else if ([types.lastObject isEqualToString:UMShareToSina]){
        
        //  新浪貌似不可以直接设置title  
    }
    
    //  暂时关闭视频分享
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:types content:titleMessage image:img location:location urlResource:nil presentedController:presentedController completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            if (completion) {
                completion([[response.data allKeys] objectAtIndex:0],YES);
            }
            
        }else{
            
            if (completion) {
                completion(@"",NO);
            }
        }
    }];
    
    
    
    
    
    //  设置分享的url格式
//    typedef enum {
//        UMSocialUrlResourceTypeDefault,             //无
//        UMSocialUrlResourceTypeImage,               //图片
//        UMSocialUrlResourceTypeVideo,               //视频
//        UMSocialUrlResourceTypeMusic,                //音乐
//        UMSocialUrlResourceTypeWeb,                //网页
//        UMSocialUrlResourceTypeCount
//    }UMSocialUrlResourceType;
//    

}




@end
