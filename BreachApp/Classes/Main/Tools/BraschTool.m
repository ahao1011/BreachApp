//
//  BraschTool.m
//  BreachApp
//
//  Created by ah on 16/4/28.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "BraschTool.h"
#import "ViewCtrlLoading.h"
#import "AHNavigationController.h"

@implementation BraschTool

+ (void)JumpToLogingWithViewController:(UIViewController *)vc{
    
    ViewCtrlLoading *login = [[ViewCtrlLoading alloc]init];
    AHNavigationController *nav = [[AHNavigationController alloc]initWithRootViewController:login];
    
    [vc presentViewController:nav animated:YES completion:nil];
}
@end
