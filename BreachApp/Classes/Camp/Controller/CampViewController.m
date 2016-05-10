//
//  CampViewController.m
//  BreachApp
//
//  Created by ah on 16/3/28.
//  Copyright © 2016年 ah. All rights reserved.
//

#define K_CampCell @"CampCell"
#define K_CellHeight 117.0f

#import "CampViewController.h"
#import "ViewCtrlCampVideo.h"
#import "ShareView.h"
#import "UmManager.h"
#import "MenuView.h"
#import "CampCell.h"

@interface CampViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CampViewController{
    
    NSMutableArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self configData];
    [self getDataFromServer];

}

- (void)getDataFromServer{
    
#warning 服务器拿取数据  这里构造本地数据
    
    
    NSArray *title = @[@"得分后卫/小前锋系统训练",@"得分后卫/小前锋强化训练",@"得分后卫/小前锋系统训练",@"得分后卫/小前锋强化训练"];
    
    for (int i=0; i<4; i++) {
        
        Bre001Res *model = [[Bre001Res alloc]init];
        model.nametitle = title[i];
        model.videoId = @"0035466";
        model.imgUrl = @"dfetygeurjgit//frehuwgh";
        
        [_dataArr addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)configData{
    
    MenuView *view = [[MenuView alloc]initWithFrame:CGRectMake(0, 0, K_ScreenWidth, 45)];
    [self.view addSubview:view];
    _dataArr = @[].mutableCopy;
    view.titleArr = @[@"位置",@"动作"];
    view.leftTabArr = @[@"前锋",@"后卫",@"哈哈"];
    view.rightTabArr = @[@"过人",@"耍酷"];
    view.leftHandle = ^(NSInteger index,NSString *title){
        
        MYLog(@"%@被点击",title);
        
    };
    view.rightHandle = ^(NSInteger index,NSString *title){
        
        MYLog(@"%@被点击",title);
        
    };
    
    
    
    [view fire];
}

- (void)configView{
    [self showLeftNavItem:NO];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:K_CampCell bundle:nil] forCellReuseIdentifier:K_CampCell];
}

#pragma mark- UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count>0?_dataArr.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CampCell *cell = [tableView dequeueReusableCellWithIdentifier:K_CampCell forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Bre001Res *model = _dataArr[indexPath.row];
    ViewCtrlCampVideo *video = [[ViewCtrlCampVideo alloc]init];
    video.model = model;
    [self.navigationController pushViewController:video animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return K_CellHeight;
}
#pragma mark- 事例
//- (IBAction)test:(id)sender {
//    
//    [ShareView appearWithCom:^(NSArray *arr) {
//        
//
//        [[UmManager defaultManager]ShareSNSToTypes:arr withtitle:@"这是一个测试标题" titleMessage:@"你还在等什么" img:[UIImage imageNamed:@"Icon-60"] location:nil urlResource:nil presentedController:self completion:^(NSString *responseName, BOOL isShareSuccess) {
//            
//            if (isShareSuccess) {
//               
//                [self showMessage:[NSString stringWithFormat:@"%@分享成功",responseName]];
//            }
//        }];
//    }];
//}


@end
