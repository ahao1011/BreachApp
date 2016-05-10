//
//  ViewCtrlSeason.m
//  BreachApp
//
//  Created by ah on 16/5/6.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "ViewCtrlSeason.h"
#import "ViewCtrMyTeam.h"

@interface ViewCtrlSeason ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewCtrlSeason{
    
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"赛季";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = K_BackColor;
    _titleArr = [NSArray arrayWithObjects:@"我的队伍",@"我要参赛",@"赛季荣誉榜", nil];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"saiji";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:cellId];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        
        ViewCtrMyTeam *myTeam = [[ViewCtrMyTeam alloc]init];
        [self.navigationController pushViewController:myTeam animated:YES];
        
    }else if (indexPath.row==1){
        
        
        
    }else if (indexPath.row==2){
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
