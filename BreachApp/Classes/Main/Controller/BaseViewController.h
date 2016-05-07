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
 *  等待层提示
 */
- (void)showWaitMessage:(NSString*)message;
/**
 *  等待层展示与隐藏
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
/**
 *  下拉刷新
 *
 *  @param tableView tableView
 *  @param Action    回调句柄
 */
- (void)setTableViewHeader:(UITableView*)tableView Action:(void (^)())Action;
/**
 *  上拉加载
 *
 *  @param tableView tableView
 *  @param Action    回调句柄
 */
- (void)setTableViewFooter:(UITableView*)tableView Action:(void (^)())Action;
/**
 *  停止刷新
 *
 *  @param tableView tableVie
 *  @param isAll     YES  表示已无更多数据可以加载  NO表示仅仅隐藏加载状态
 */
- (void)EndFreshTableView:(UITableView*)tableView IsAllData:(BOOL)isAll;
/**
 *  返回按钮,界面跳转  可覆写
 */
- (void)Doback;
/**
 *  YES 显示导航栏返回按钮  NO 显示
 */
- (void)showLeftNavItem:(BOOL)show;
@end
