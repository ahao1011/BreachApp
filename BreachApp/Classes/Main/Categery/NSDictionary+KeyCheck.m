//
//  NSDictionary+KeyCheck.m
//  Hd_JSHT
//
//  Created by ah on 16/1/19.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "NSDictionary+KeyCheck.h"

@implementation NSDictionary (KeyCheck)

- (BOOL)ISHaveTheKey:(NSString *)key{
    
    if([[self allKeys] containsObject:key]){
        return YES;
    }
    return NO;
}



@end
