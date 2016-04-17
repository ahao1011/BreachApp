//
//  BaseViewController.h
//  BabyDemo
//
//  Created by ah on 15/10/14.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  转圈圈
 */
- (void)showWaitView:(BOOL)IsShow;
/**
 *  提示信息
 */
- (void)showMessage:(NSString*)message;
/**
 *  弹框提示信息
 */
- (void)showAlertMessage:(NSString *)alertMes;

@end
