//
//  ViewCtrlPersonInfo.m
//  BreachApp
//
//  Created by ah on 16/5/10.
//  Copyright © 2016年 ah. All rights reserved.
//

#define K_PerInfoCell @"PerInfoCell"

#import "ViewCtrlPersonInfo.h"
#import "PerInfoCell.h"

@interface ViewCtrlPersonInfo ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewCtrlPersonInfo{
    
    NSDictionary *DataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self configData];
}

/**
 *  数据
 */
- (void)configData{
    
    self.navigationItem.title = @"个人资料";
    DataDic = @{
                
                @"0":@[@"头像",@"昵称",@"性别",@"球龄",@"身高",@"体重",@"锋位",@"所在城市",@"大学"],
                @"1":@[@"我的二维码"]
                
                };
}
/**
 *  界面
 */
- (void)configView{
    
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:K_PerInfoCell bundle:nil] forCellReuseIdentifier:K_PerInfoCell];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section) {
        return 1;
    }else{
        return 9;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PerInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:K_PerInfoCell];
    cell.lableName.text = [DataDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]][indexPath.row];
    Bre003Res *model = [[Bre003Res alloc]init];
    model.Name = @"hha";
    model.Sex = @"男";
    model.BoardAge = @"3";
    model.Height = @"173";
    model.weight = @"55";
    model.Loca = @"hh";
    model.City = @"石家庄";
    model.Univer = @"keda";
    [cell makeModel:model indexpath:indexPath];
    return cell;
}





@end
