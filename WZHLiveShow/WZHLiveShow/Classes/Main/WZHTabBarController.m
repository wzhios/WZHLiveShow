//
//  WZHTabBarController.m
//  百思不得姐
//
//  Created by wszyxc on 16/6/15.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHTabBarController.h"
#import "WZHNavigationController.h"

//直播秀
#import "WZHLiveViewController.h"

//我
#import "WZHProfileViewController.h"

#import "WZHTabBar.h"

#import "WZHPreviewController.h"



@interface WZHTabBarController ()

@end

@implementation WZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addAllChildViewConttrollers];
    
    WZHTabBar *tabBar = [[WZHTabBar alloc]init];
    
    tabBar.block = ^{
        
        WZHPreviewController *preVC = [[WZHPreviewController alloc]init];
        
        [self presentViewController:preVC animated:YES completion:^{
            
        }];
        
    };
    
   //因为tabBar为只读,所以用KVC 设置
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    [self setupTabBarBackgroundImage];
    
    
    
   
}



#pragma mark ---- <设置tabBar背景图片>
- (void)setupTabBarBackgroundImage {
    UIImage *image = [UIImage imageNamed:@"tab_bg"];
    
    //图片320*50
    
    CGFloat top = 40; // 顶端盖高度
    CGFloat bottom = 40 ; // 底端盖高度
    CGFloat left = 100; // 左端盖宽度
    CGFloat right = 100; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    UIImage *tabBgImage = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    self.tabBar.backgroundImage = tabBgImage;

    [[UITabBar appearance] setShadowImage:[UIImage new]];
  //  [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

//自定义TabBar高度
- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 60;
    tabFrame.origin.y = self.view.frame.size.height - 60;
    self.tabBar.frame = tabFrame;
    

}





- (void)addAllChildViewConttrollers{
    
    //添加左侧的直播控制器
    WZHLiveViewController *liveVC = [[WZHLiveViewController alloc]init];
    
    [self addOneChildViewController:liveVC image:@"tab_live" selectedImage:@"tab_live_p" title:nil isHasNavigationController:YES];
    
    //添加右侧的关于我
    
    WZHProfileViewController *profileVC = [[WZHProfileViewController alloc]init];
    
    [self addOneChildViewController:profileVC image:@"tab_me" selectedImage:@"tab_me_p" title:nil isHasNavigationController:NO];
    
}



- (void)addOneChildViewController:(UIViewController *)childVC image:(NSString *)image selectedImage:(NSString *)selectImage title:(NSString *)title isHasNavigationController:(BOOL)isHas{
    
    UIImage *originalImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVC.tabBarItem.image = originalImage;
    
    UIImage *originalSelectImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVC.tabBarItem.selectedImage = originalSelectImage;
    
    childVC.tabBarItem.title = title;
    
    if (isHas) {
        //实例化导航控制器
        WZHNavigationController *nav = [[WZHNavigationController alloc]initWithRootViewController:childVC];
        
        //添加导航控制器作为标签控制器的根控制器
        
        [self addChildViewController:nav];
    }else{
        
        //直接添加控制器作为跟控制器
        [self addChildViewController:childVC];
        
    }
    
    
    
}



@end
