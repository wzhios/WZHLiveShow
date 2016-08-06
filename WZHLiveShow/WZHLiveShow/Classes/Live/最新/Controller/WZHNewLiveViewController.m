//
//  WZHNewLiveViewController.m
//  WZHLiveShow
//
//  Created by wszyxc on 16/8/2.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHNewLiveViewController.h"
#import <Masonry.h>


@interface WZHNewLiveViewController ()


@end


@implementation WZHNewLiveViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI{
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:IMG(@"welcome_2")];
    
    [self.view addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
    
}


@end

