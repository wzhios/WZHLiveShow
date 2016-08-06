//
//  WZHAttentionViewController.m
//  WZHLiveShow
//
//  Created by wszyxc on 16/8/2.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHAttentionViewController.h"
#import <Masonry.h>

@interface WZHAttentionViewController ()

@end

@implementation WZHAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.view.backgroundColor = RandomColor;
    [self setupUI];

}


- (void)setupUI{
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:IMG(@"welcome_1")];
    
    [self.view addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
    
}



@end
