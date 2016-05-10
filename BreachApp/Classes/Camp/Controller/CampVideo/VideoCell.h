//
//  VideoCell.h
//  BreachApp
//
//  Created by ah on 16/5/5.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^videoBlock)(NSInteger index,NSString *title);

@interface VideoCell : UITableViewCell

@property (nonatomic,copy)videoBlock block;

@property (nonatomic,strong)Bre002ResItem *model;

@end
