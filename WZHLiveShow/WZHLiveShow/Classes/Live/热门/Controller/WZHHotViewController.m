//
//  WZHHotViewController.m
//  WZHLiveShow
//
//  Created by wszyxc on 16/8/2.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHHotViewController.h"
#import "ALinNetworkTool.h"

#import "WZHLiveModel.h"

#import <MJExtension.h>

#import <IJKMediaFramework/IJKMediaFramework.h>

#import <UIImageView+WebCache.h>

#import "PlayerViewController.h"

#import "WZHLiveCell.h"

#import <UIImageView+WebCache.h>

#import <MJRefresh.h>



@interface WZHHotViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (strong,nonatomic) NSMutableArray * dataArray;
/** 直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;


@property (weak,nonatomic) UITableView * tableView;

@property (assign,nonatomic) int  page;


@end



static NSString * LiveControllerID = @"LiveControllerID";



@implementation WZHHotViewController


- (NSArray *)dataArray{
    
    if(!_dataArray){
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置界面
    [self setupTableView];
    
    //添加下拉刷新
    [self setupRefresh];
    
    //初始化page
    self.page = 1;
    
    //获取网络数据
    [self getLiveDataWithPage:self.page];
    
    
}

- (void)setupRefresh{
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page++;
        [self getLiveDataWithPage:self.page];
    
    }];
    
  
}
                                 



//添加tableView

- (void)setupTableView{
    
    
    UITableView *tab = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView = tab;
    
    tab.dataSource = self;
    
    tab.delegate = self;
    
    tab.rowHeight = 300;
    

    [tab registerNib:[UINib nibWithNibName:NSStringFromClass([WZHLiveCell class]) bundle:nil] forCellReuseIdentifier:LiveControllerID];
    
    [self.view addSubview:tab];
    
    
    
}



//获取网络数据
- (void)getLiveDataWithPage:(int)page{

    [self.tableView.mj_header endRefreshing];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%d",page];
    
    
    [[ALinNetworkTool shareTool] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
   
        
        //将获取到的数据源数组转换成模型数组
        NSMutableArray *tempArr = [NSMutableArray array];
        tempArr = [WZHLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
        [tempArr addObjectsFromArray:self.dataArray];
        
        self.dataArray = tempArr;
    
        [self.tableView reloadData];
        
        NSLog(@"%ld",self.dataArray.count);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"数据加载失败");
        
    }];
    
    
}




/**
 *  tableView的数据源和代理
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WZHLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:LiveControllerID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor brownColor];
    
    WZHLiveModel *model = self.dataArray[indexPath.row];
    
    cell.nameLabel.text = model.myname;
    
    NSURL *url = [NSURL URLWithString:model.bigpic];
    
    [cell.imgView sd_setImageWithURL:url];
    
    
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WZHLiveModel *model = self.dataArray[indexPath.row];
    
    
    PlayerViewController *playVC = [[PlayerViewController alloc]init];
    
    playVC.liveUrl = model.flv;
    

    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:playVC];
    
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    
}





@end
