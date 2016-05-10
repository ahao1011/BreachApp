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

/**主色调(导航栏 按钮)*/
#define K_AppColor  AHColor(114, 119, 165)
/**tabBar背景色*/
#define K_TabBarColor  AHColor(31, 32, 33)
/**线条颜色*/
#define K_LineColor  AHColor(220, 220, 220)
/**界面背景色*/
#define K_BackColor  AHColor(237, 238, 239)
/**红色*/
#define K_RedColor  AHColor(227, 63, 62)



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




