//
//  AHData.h
//  BannNewVersion
//
//  Created by ah on 16/3/25.
//  Copyright © 2016年 ah. All rights reserved.
//

//  数据类


//  通知类
static NSString *const jj= @"hahha";

//  NSUserDefaults类
static NSString *const jjj= @"hahha";
// 其他类别
static NSString *const jsj= @"hahha";



//  颜色

/**导航条标题*/     
#define kColorNavBlack [UIColor colorWithHexString:@"#333333"]
/**自定义cell的标题*/
#define kColorDarkGray [UIColor colorWithHexString:@"#666666"]
/**自定义cell的副标题 或UILabel上字体颜色*/
#define kColorLightGray [UIColor colorWithHexString:@"#999999"]
/**列表二级cell的背景颜色*/
#define kColorLightGrayBg [UIColor colorWithHexString:@"#F9F9F9"]
/**整个工程主题蓝色 或底部左按钮蓝色*/
#define kColorThemeBlueBg [UIColor colorWithHexString:@"#33A1F4"]
/**底部左按钮选中蓝色*/
#define kColorLBtnSelectBlueBg [UIColor colorWithHexString:@"#228FE1"]
/**底部右按钮未选中蓝色*/
#define kColorRBtnBlueBg [UIColor colorWithHexString:@"#74BFF7"]
/**底部右按钮选中蓝色*/
#define kColorRBtnSelectBlueBg [UIColor colorWithHexString:@"#67ADE2"]
/**底部按钮置灰*/
#define kColorBottomBtnGaryBg [UIColor colorWithHexString:@"#D4D4D4"]
/**错误输入提示字体颜色*/
#define kColorErrorTipText [UIColor colorWithHexString:@"#E91B00"]
/**错误输入提示背景颜色*/
#define kColorErrorTipBg [UIColor colorWithHexString:@"#FCEDCF"]
/**关于金钱的字体颜色*/
#define kColorMoney [UIColor colorWithHexString:@"#EE4635"]
/**TabBar选中颜色*/
#define kColorTabBarSelect [UIColor colorWithHexString:@"#4080D0"]
/**TabBar未选中颜色*/
#define kColorTabBarUnSelect [UIColor colorWithHexString:@"#8F9CAC"]

/**立即投资蓝色*/
#define kColorInvestBlueBg [HYColor colorWithStringHex:@"#39A3F2"]

typedef enum {
    UITypeUploadPhotoResetTradePassword,
    UITypeUploadPhotoChangeMobileUnUseing,
    UITypeUploadPhotoResetLoginPassword
}UITypeUploadPhoto;//上传照片类型

typedef enum{
    UIBankCardTypeUnionPay,
    UIBankCardTypeTranfer,
    UIBankCardTypeHBBank
}UIChangeBankCardType;//选择银行卡的认证类型

typedef enum {  //  银行卡类型
    /** 默认卡  */
    BankTypeDefault,
    /** 主卡 */
    BankTypeMainCard,
    /** 副卡 */
    BankTypeSecCard
    
}BankType;

typedef enum {  //  产品类型
    /** 默认产品  */
    FundDefault                     =0,
    /**中加*/
    FundMidAdd                      =1 << 0,
    /**彩虹*/
    FundRainbow                     =1 << 1,
    /**南方理财60天E*/
    FundsouthFinanceSixtyDaysE      =1 << 2,
    /**票据*/
    FundPaper                       =1 << 3,
    /**步步增利*/
    FundStep                        =1 << 4,
    /** 南方现金通E*/
    FundSouthernCashFluxE           =1 << 5,
    /**富盈*/
    FundRichSurplus                 =1 << 6,
    /**富盈5号*/
    FundRichSurplusFive             =1 << 7
    
}FundType;




