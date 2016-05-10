//
//  ViewCtrMyTeam.m
//  BreachApp
//
//  Created by ah on 16/5/6.
//  Copyright © 2016年 ah. All rights reserved.
//

#import "ViewCtrMyTeam.h"

@interface ViewCtrMyTeam ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewCtrMyTeam{
    
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的队伍";
    _titleArr = [NSArray arrayWithObjects:@"我组建的队伍",@"我要加入队伍",@"我要创建队伍", nil];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = K_BackColor;
    [self.tableView reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"wodeduiwu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
    
}




@end
