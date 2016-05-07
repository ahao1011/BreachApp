//
//  AhResult.h
//  BreachApp
//
//  Created by ah on 16/4/29.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"



@interface AhResult : BaseObject

@end


#import "AHTabBarViewController.h"
/**
 *  用户信息
 */
@interface UserInfo : AhResult


+ (instancetype)DefaultUser;
/**是否登录*/
@property (nonatomic,assign)BOOL Login;
@property (nonatomic,strong)AHTabBarViewController *tabBarVcController;
@end


/**
 *  训练营首页视频分类
 */
@interface Bre001Res : AhResult

@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *nametitle;
@property (nonatomic,copy)NSString *videoId;

@end

/**
 *  训练营视频列表
 */
@interface Bre002Res : AhResult

@property (nonatomic,copy)NSMutableArray *list;

@end



/**
 *  训练营视频列表ietm
 */
@interface Bre002ResItem : AhResult

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *imgUrl;


@end



