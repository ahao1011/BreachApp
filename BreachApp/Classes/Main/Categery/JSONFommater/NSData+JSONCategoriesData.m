//
//  NSData+JSONCategoriesData.m
//  tcpoctest
//
//  Created by WangQing on 13-12-31.
//  Copyright (c) 2013年 gump. All rights reserved.
//

#import "NSData+JSONCategoriesData.h"

@implementation NSData (JSONCategoriesData)

- (id)JSONValue {
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com