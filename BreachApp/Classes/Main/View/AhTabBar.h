//
//  AhTabBar.h
//  xinlang
//
//  Created by ah on 15/10/2.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AhTabBarButton.h"
@class AhTabBar;
@protocol AhTabBarDelegate <NSObject>

- (BOOL)tabBar:(AhTabBar*)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface AhTabBar : UIView


@property (nonatomic,weak) id<AhTabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
