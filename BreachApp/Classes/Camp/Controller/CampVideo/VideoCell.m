//
//  VideoCell.m
//  BreachApp
//
//  Created by ah on 16/5/5.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lableTitle;


@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.img.backgroundColor = AHRandomColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Bre002ResItem *)model{
    
    _model = model;
#warning 图片处理
    self.lableTitle.text = model.title;
}
#pragma mark- 分享
- (IBAction)btnShareAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (_block) {
        _block(2,btn.titleLabel.text);
    }
}

#pragma mark- 收藏
- (IBAction)btnCollecAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (_block) {
        _block(1,btn.titleLabel.text);
    }
}
#pragma mark- 下载
- (IBAction)btnDownAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (_block) {
        _block(0,btn.titleLabel.text);
    }
}

@end
