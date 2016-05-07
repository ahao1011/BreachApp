//
//  AhBadgeButton.m
//  BreachApp
//
//  Created by ah on 15/10/9.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import "AhBadgeButton.h"
#import "UIImage+Ah.h"

@implementation AhBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizeImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.userInteractionEnabled = NO;
    }
    return self;
}


- (void)setBadgeValue:(NSString *)badgeValue{
    
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGRect frame = self.frame;
        CGFloat badgeH=self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if(badgeValue.length>1){
            // 文字的尺寸
            CGSize badgeSize=[badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, badgeH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
            badgeW=badgeSize.width+10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame =frame;
        
    }else{
        
        self.hidden = YES;
    }
    

}
@end
