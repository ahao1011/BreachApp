//
//  MeHeader.h
//  BreachApp
//
//  Created by ah on 16/5/6.
//  Copyright © 2016年 ah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeHeader : UIView

/**背景*/
@property (nonatomic,strong)UIImage *backImg;
/**图像*/
@property (nonatomic,strong)UIImage *userImg;
/**名称*/
@property (nonatomic,copy)NSString  *name;
/**手机号*/
@property (nonatomic,copy)NSString *num;
/**默认self*/
@property (nonatomic,strong)UIViewController *target;


@end
