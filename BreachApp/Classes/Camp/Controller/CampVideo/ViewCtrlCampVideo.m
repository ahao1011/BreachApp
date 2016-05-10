//
//  ViewCtrlCampVideo.m
//  BreachApp
//
//  Created by ah on 16/5/5.
//  Copyright © 2016年 ah. All rights reserved.
//

#define K_VideoCell @"VideoCell"

#import "ViewCtrlCampVideo.h"
#import "VideoCell.h"
#import "KRVideoPlayerController.h"
#import "ViewCtrlShare.h"

@interface ViewCtrlCampVideo ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic,strong)Bre002Res* listMOdel;

@property (nonatomic, strong) KRVideoPlayerController *videoController;


@end

@implementation ViewCtrlCampVideo{
    
    Bre002Res *_listModel;
    
    NSMutableArray *_tempDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self configData];
    [self getDataFromServer];
    
}

- (void)getDataFromServer{
    
    _tempDataArr = [[NSMutableArray alloc]init];

    NSArray *title = @[@"得分后卫/小前锋系统训练",@"得分后卫/小前锋强化训练",@"得分后卫/小前锋系统训练",@"得分后卫/小前锋强化训练"];
    for (int i = 0; i<4; i++) {
        
        
        Bre002ResItem *item = [[Bre002ResItem alloc]init];
        item.title = title[i];
        item.imgUrl = @"u85wyu4956u";
        [_tempDataArr addObject:item];
    }
    
    
    
    [self.tableView reloadData];
    
}

- (void)configData{
    
    
   
}

- (void)configView{
    
    self.navigationItem.title = @"视频";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:K_VideoCell bundle:nil] forCellReuseIdentifier:K_VideoCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return _listModel.list.count>0?_listModel.list.count:1;
    return _tempDataArr.count>0?_tempDataArr.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCell  *cell = [tableView dequeueReusableCellWithIdentifier:K_VideoCell forIndexPath:indexPath];
//    cell.model = _listModel.list[indexPath.row];
    cell.model = _tempDataArr[indexPath.row];
    __unsafe_unretained VideoCell *weakCell = cell;
    cell.block = ^(NSInteger index,NSString *title){
        
        MYLog(@"%zd====%@",index,title);
        if (index==2) {
            
            [self gotoShare:weakCell.model];
        }
    };
    return cell;
}

- (void)gotoShare:(Bre002ResItem *)model{
    
    ViewCtrlShare *Share = [[ViewCtrlShare alloc]init];
    Share.model = model;
    [self.navigationController pushViewController:Share animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 198.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    [self playVideoWithURL:videoURL];
    
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}


@end
