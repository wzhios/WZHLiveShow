//
//  WZHNavigationController.m
//  百思不得姐
//
//  Created by wszyxc on 16/6/15.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHNavigationController.h"

@interface WZHNavigationController ()

@end

@implementation WZHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//设置navigation背景
+ (void)initialize {
    
    if (self == [WZHNavigationController class]) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        [bar setBackgroundImage:[UIImage imageNamed:@"global_background"] forBarMetrics:UIBarMetricsDefault];
    }
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    
    [super pushViewController:viewController animated:YES];
}



@end
