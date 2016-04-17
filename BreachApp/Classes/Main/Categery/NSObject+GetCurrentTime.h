//
//  NSObject+GetCurrentTime.h
//  祥鹏
//
//  Created by 易思凯 on 15/11/30.
//  Copyright © 2015年 zhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GetCurrentTime)
- (NSString *)getCurrentWeek;
- (NSString *)getCurrentDay;
- (NSString *)getSelectedDay:(NSString *)selected;
- (NSString *)getSelectedWeek:(NSString *)selected;
- (NSString *)getBeforeDay:(NSString *)selected;

@end
