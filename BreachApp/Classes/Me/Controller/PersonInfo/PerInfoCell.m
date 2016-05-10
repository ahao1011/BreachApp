//
//  PerInfoCell.m
//  BreachApp
//
//  Created by ah on 16/5/10.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "PerInfoCell.h"

@interface PerInfoCell ()



@property (weak, nonatomic) IBOutlet UILabel *lableTitle;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@end

@implementation PerInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.img.layer.cornerRadius = self.img.width;
    self.img.layer.masksToBounds = YES;
    
}

- (void)makeModel:(Bre003Res *)model indexpath:(NSIndexPath *)IndexPath{
    
    
    if (!IndexPath.section) {
        
        self.accessoryType = UITableViewCellAccessoryNone;

        if (model!=nil) {
            if (IndexPath.row==0) {
                
                self.lableTitle.hidden = YES;
                self.img.hidden = NO;
#warning 这里拿网络图
                self.img.image = [UIImage imageNamed:@"ic_share_tengxun"];
            }else{
                self.lableTitle.hidden = NO;
                self.img.hidden = YES;
                if (IndexPath.row==1) {
                    
                    self.lableTitle.text = model.Name;
                }else if (IndexPath.row==2){
                    self.lableTitle.text = model.Sex;
                }else if (IndexPath.row==3){
                    self.lableTitle.text = model.BoardAge;
                }else if (IndexPath.row==4){
                    self.lableTitle.text = model.Height;
                }else if (IndexPath.row==5){
                    self.lableTitle.text = model.weight;
                }else if (IndexPath.row==6){
                    self.lableTitle.text = model.Loca;
                }else if (IndexPath.row==7){
                    self.lableTitle.text = model.City;
                }else if (IndexPath.row==8){
                    self.lableTitle.text = model.Univer;
                }
            }
        }
        
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.lableTitle.hidden = YES;
        self.img.hidden = YES;
    }
}


@end
