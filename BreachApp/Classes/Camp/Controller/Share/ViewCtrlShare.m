//
//  ViewCtrlShare.m
//  BreachApp
//
//  Created by ah on 16/5/5.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "ViewCtrlShare.h"
#import "shareButton.h"
#import "UmManager.h"

@interface ViewCtrlShare ()


@property (strong, nonatomic)  UIImageView *img;
@property (strong, nonatomic)  UILabel *titleLable;


@end

@implementation ViewCtrlShare

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configView];
    
}

- (void)configView{
    
    self.navigationItem.title = @"我要分享";
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 60, 60)];
    [self.view addSubview:img];
    img.backgroundColor = [UIColor orangeColor];
    self.img = img;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(95, 35, 200, 21)];
    titleLable.text = self.model.title;
    [self.view addSubview:titleLable];
    self.titleLable = titleLable;
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(30, 110, 100, 21)];
    lable.text = @"分享至:";
    [self.view addSubview:lable];
    
    CGFloat btnW = 80;
    CGFloat Magin = (K_ScreenWidth-4*btnW)*0.2;
    
    NSArray *nameArr = @[@"ic_share_pengyouquan",@"ic_share_qq",@"ic_share_kongjian",@"ic_share_weixin"];
    NSArray *titleArr = @[@"朋友圈",@"QQ好友",@"QQ空间",@"微信好友"];
    
    for (int i = 0; i<4; i++) {
        
         shareButton*btn = [[shareButton alloc]initWithFrame:CGRectMake(Magin + i*(Magin + btnW), 170, btnW, btnW)];
        btn.tag = 10+i;
        [btn setATitle:titleArr[i]];
        [btn setAImage:[UIImage imageNamed:nameArr[i]]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
}

- (void)btnAction:(shareButton*)btn{
    
    NSString *nameStr = nil;
    switch (btn.tag) {
        case 10:{  // 朋友圈
            
            nameStr =  UMShareToWechatTimeline;
            
        }
            
            break;
        case 11:{  // qq
            
            nameStr = UMShareToQQ;
        }
            
            break;
        case 12:{  // qq空间
            
            nameStr = UMShareToQzone;
        }
            
            break;
        case 13:{  //微信好友
            
            nameStr = UMShareToWechatSession;
        }
            
            break;
            
        default:
            break;
    }
    
    
    [[UmManager defaultManager]ShareSNSToTypes:@[nameStr] withtitle:self.model.title titleMessage:@"王向垒个二货" img:[UIImage imageNamed:@"ic_share_weibo"] location:nil urlResource:nil presentedController:self completion:^(NSString *responseName, BOOL isShareSuccess) {
        
        if (isShareSuccess) {
            
            [self showMessage:[NSString stringWithFormat:@"%@分享成功",responseName]];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
