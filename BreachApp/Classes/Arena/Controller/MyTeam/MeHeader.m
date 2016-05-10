//
//  MeHeader.m
//  BreachApp
//
//  Created by ah on 16/5/6.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "MeHeader.h"
#import "UIImage+AhExtion.h"


@interface MeHeader ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic)  UIView *view;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UIImageView *userImgView;
@property (nonatomic,strong)UILabel *lableName;
@property (nonatomic,strong)UILabel *lablePhoneNum;
@property (nonatomic,strong)AhAlertView *sheetView;

@end

@implementation MeHeader{
    
    
    UIImagePickerController *_imgController; // 相册管理
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configView];
        [self configData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configView];
        [self configData];
    }
    return self;
}

- (void)configData{
    
    _imgController = [UIImagePickerController new];
    _imgController.delegate = self;
    _imgController.allowsEditing = YES;
}

- (void)configView{
    
    self.backgroundColor =[UIColor greenColor];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.imgView = imgView;
    [self addSubview:imgView];
    
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat btnX =  self.width - btnW - 35;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, 35, btnW, btnH)];
    [btn setATitle:@"更换背景"];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(Chang) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    CGFloat userW = 60;
    CGFloat userH = 60;
    CGFloat userY = (self.width - userH)*.5f;
    
    UIImageView *userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, userY, userW, userH)];
    self.userImgView = userImgView;
    self.userImgView.layer.cornerRadius = userImgView.width *0.5f;
    self.userImgView.layer.masksToBounds = YES;
    [self addSubview:userImgView];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userImgView.frame)+5, CGRectGetMinY(userImgView.frame), 150, 21)];
    self.lableName = name;
    [self addSubview:name];
    
    UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(name.frame), CGRectGetMaxY(name.frame)+3, 150, 21)];
    self.lablePhoneNum = num;
    [self addSubview:num];
    
    _sheetView = [[AhAlertView alloc]initWithSheetViewTitleArr:@[@"相册",@"照相机"] sheetHandle:^(NSInteger index) {
        
        MYLog(@"%zd",index);
        if (!index) {
            
            [self PtotoAction];
        }else{
            
            [self cameraAction];
        }
        
    } cancleHandle:^{
        [AhAlertView hiddenFromWindow];
    }];
    
}

#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    MYLog(@"%@",info);
    
    _imgController.allowsEditing = YES;
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        
        UIImageWriteToSavedPhotosAlbum([info objectForKey:UIImagePickerControllerEditedImage], nil, nil, nil);
        
    }else{
        
    }
    self.backImg =[info objectForKey:UIImagePickerControllerEditedImage];
    [_imgController dismissViewControllerAnimated:YES completion:nil];
}

/** 相册 */
- (void)PtotoAction{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        _imgController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self.target presentViewController:_imgController animated:YES completion:^{
            MYLog(@"调取相册");
        }];
        
    }
}
/** 拍照 */
- (void)cameraAction{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        _imgController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.target presentViewController:_imgController animated:YES completion:^{
            MYLog(@"调取相册成功");
        }];
    }else{
        [AhAlertView alertViewWithTitle:@"警告" message:@"照相机不可用"];
    }
}

- (void)Chang{
    
    [_sheetView show];
}

- (void)setBackImg:(UIImage *)backImg{
    
    _backImg = backImg;
    //
    self.imgView.image = [backImg imgWithBlur];
}

- (void)setUserImg:(UIImage *)userImg{
    
    _userImg = userImg;
    self.userImgView.image = userImg;
}

- (void)setName:(NSString *)name{
    
    _name = name;
    self.lableName.text = name;
}

- (void)setNum:(NSString *)num{
    
    _num = num;
    self.lablePhoneNum.text = num;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
//    self.width = K_ScreenWidth;
    
}

@end
