//
//  NSDictionary+KeyCheck.h
//  Hd_JSHT
//
//  Created by ah on 16/1/19.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KeyCheck)

/**
 *  检查key是否存在,用于容错
 */
- (BOOL)ISHaveTheKey:(NSString *)key;

@end
