//
//  BaseObject.m
//  BabyDemo
//
//  Created by ah on 15/10/16.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    [super setValue:value forKey:key];
}


- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self= [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic{
    
    return [[self alloc]initWithDic:dic];
}


@end
