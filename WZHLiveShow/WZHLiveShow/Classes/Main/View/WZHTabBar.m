//
//  WZHTabBar.m
//  WZHLiveShow
//
//  Created by wszyxc on 16/8/2.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHTabBar.h"

@implementation WZHTabBar


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //设置子控件
        [self setupUI];
        
        
    }
    return self;
}

- (void)setupUI{
    
    //添加一个按钮 放在中间
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:IMG(@"tab_room") forState:UIControlStateNormal];
    [btn setImage:IMG(@"tab_room_p") forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    [btn sizeToFit];
    
    
}

- (void)btnClick{
    //定义一个block,让tabBarController modal出一个开始推流的控制器
    
    if (self.block) {
        self.block();
    }
    
}



- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    //拿到item,设置图片偏移量
//    for (UITabBarItem *item in self.items) {
//
//            item.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
//    }
    
    CGFloat itemW = (ScreenWidth - 48)/2;
    CGFloat itemH = 48;
    
    NSInteger index = 0;
    
    //拿到三个子控件 设置位置
    for (UIView *item in self.subviews) {
        
        if ([item isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            index++;
            
            if (index == 1) {
                item.frame = CGRectMake(0, 15, itemW, itemH);
            }else{
                item.frame = CGRectMake(ScreenWidth-itemW, 15, itemW, itemH);
            }
            
        }else if ([item isKindOfClass:[UIButton class]]){
            
            item.frame = CGRectMake(itemW, 8, 48, itemH);
        }
        
    }
    
}



@end
