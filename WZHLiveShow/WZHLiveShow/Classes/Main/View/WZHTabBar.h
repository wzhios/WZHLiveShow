//
//  WZHTabBar.h
//  WZHLiveShow
//
//  Created by wszyxc on 16/8/2.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)();


@interface WZHTabBar : UITabBar


@property (copy,nonatomic) Block block;


@end
