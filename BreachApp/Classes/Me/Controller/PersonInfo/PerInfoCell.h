//
//  PerInfoCell.h
//  BreachApp
//
//  Created by ah on 16/5/10.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerInfoCell : UITableViewCell

@property (nonatomic,strong)Bre003Res *model;

@property (weak, nonatomic) IBOutlet UILabel *lableName;

- (void)makeModel:(Bre003Res*)model indexpath:(NSIndexPath*)IndexPath;

@end
