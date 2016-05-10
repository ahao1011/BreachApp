//
//  AhResult.m
//  BreachApp
//
//  Created by ah on 16/4/29.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "AhResult.h"

@implementation AhResult

@end

#pragma mark- 用户信息
@implementation UserInfo

+ (instancetype)DefaultUser{
    
    static UserInfo *user = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        user = [[UserInfo alloc]init];
    });
    return user;
}
@end

@implementation Bre001Res

@end



@implementation Bre002Res

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"Bre002ResItem",
             };
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc]init];
    }
    return self;
}

@end


@implementation Bre002ResItem

@end


@implementation Bre003Res

@end
