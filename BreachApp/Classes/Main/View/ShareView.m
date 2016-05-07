//
//  ShareView.m
//  tefubao
//
//  Created by ah on 15/12/1.
//  Copyright © 2015年 hzc. All rights reserved.
//


//- (void)ShareSNSToTypes:(NSArray *)types withtitleMessage:(NSString *)titleMessage img:(id)img location:(CLLocation *)location urlResource:(NSString *)url
//presentedController:(UIViewController *)presentedController
//completion:(void (^)(NSString * responseName ,BOOL isShareSuccess))completion


#define K_Matio 0.75f

#import "ShareView.h"
#import "shareButton.h"
#import "UIView+Extension.h"
#import "UMSocial.h"
#import "UmManager.h"
typedef void(^ShareViewBlock)(NSArray *arr);
@interface ShareView ()

@property (nonatomic,strong)UIScrollView *shareScrollView;
@property (nonatomic,strong)UIView *cancleView;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (copy,nonatomic) ShareViewBlock block;

/**
 *  m蒙板
 */
@property (nonatomic,strong)UIView *backView;

@end

@implementation ShareView

+ (void)appearWithCom:(void(^)(NSArray* arr))com{
    
    ShareView *share = nil;
    if (share==nil) {
        share = [[ShareView alloc]initWithFrame:CGRectMake(0, K_ScreenHeight, K_ScreenWidth, K_ScreenHeight*0.45)];
    }
    share.block =com;
    [share appear];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor =[UIColor whiteColor];
        [self addsubViews];
        self.layer.cornerRadius = 13.5f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

/**
 *  添加子控件
 */
- (void)addsubViews{
    
   
    UIScrollView *shareScrollView = [[UIScrollView alloc]init];
    [self addSubview:shareScrollView];
    self.shareScrollView = shareScrollView;
    UIView *cancleView = [[UIView alloc]init];
    [self addSubview:cancleView];
    self.cancleView = cancleView;
    _backView = [[UIView alloc]init];
}

/**
 *  子控件frame
 */
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //shareScrollView 的framg
    
    self.shareScrollView.frame = CGRectMake(0, 0, self.width, self.height * K_Matio);
    // 取消按钮面板
    self.cancleView.frame = CGRectMake(0, self.shareScrollView.height, self.width, self.height * (1-K_Matio));
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.cancleView.width, self.cancleView.height)];
    MYLog(@"%@",NSStringFromCGRect(btn.frame));
    [btn setTitleColor:AHColor(16, 129, 255) forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancleBtn = btn;
    [self.cancleView addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self configShare];

}

/**
 *  添加分享面板
 */
- (void)configShare{
    
    NSArray *imageArr = @[@"ic_share_weibo",@"ic_share_kongjian",@"ic_share_qq",@"ic_share_weixin",@"ic_share_pengyouquan"];
    NSArray *titleArr = @[@"新浪微博",@"QQ空间",@"QQ",@"微信",@"朋友圈"];
    for (int i = 0; i<imageArr.count; i++) {
        int rank = i / 4;// 行
        int arrange = i%4; //列
        CGFloat w = K_ScreenWidth/4;
        CGFloat h = w;
        shareButton *btn = [[shareButton alloc]initWithFrame:CGRectMake(w*arrange,h*rank, w, h)];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 1000+1+i;
        [btn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchDown];
        [self.shareScrollView addSubview:btn];
        if (i==imageArr.count-1) {
            
            self.shareScrollView.contentSize = CGSizeMake(0, btn.y + btn.height);
        }
    }
    
}

- (void)btnAction1:(shareButton *)btn{
    
    switch (btn.tag) {
            
        case 1001: { //新浪微博
            NSArray *arr = [NSArray arrayWithObject:UMShareToSina];
            [self Share:arr];
        }
            break;
        case 1002: { // qq空间
            NSArray *arr = [NSArray arrayWithObject:UMShareToQzone];
            [self Share:arr];            }
            break;
        case 1003:{ // qq
            NSArray *arr = [NSArray arrayWithObject:UMShareToQQ];
            [self Share:arr];
        }
            break;
        case 1004:{ //微信
            NSArray *arr = [NSArray arrayWithObject:UMShareToWechatSession];
            [self Share:arr];
        }
            break;
        case 1005: {// 微信朋友圈
            NSArray *arr = [NSArray arrayWithObject:UMShareToWechatTimeline];
            [self Share:arr];
        }
            break;
        case 1006:{ //腾讯微博l,  // 弃用
            NSArray *arr = [NSArray arrayWithObject:UMShareToTencent];
            [self Share:arr];
        }
            break;
    }
    
}

- (void)Share:(NSArray *)arr{
    
    [self hidden];
    
    if (_block) {
        _block (arr);
    }
    
}


- (void)btnClick:(shareButton *)btn{
    
    
    [self hidden];
}

- (void)appear{
    self.backView = [self creatView];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.backView];
    [window addSubview:self];
    [UIView animateWithDuration:.5f animations:^{
        self.y = K_ScreenHeight - self.height;
        _backView.alpha = 0.5;
    }];
}

- (UIView *)creatView{
    
    UIView *backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor blackColor];
    MYLog(@"蒙板========%@",NSStringFromCGRect(_backView.frame));
    backView.alpha = 0;
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [backView addGestureRecognizer:recongnizer];
    return backView;
}

- (void)hidden{
    [UIView animateWithDuration:.5f animations:^{
        self.y = K_ScreenHeight;
        _backView.alpha = 0;
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

@end
