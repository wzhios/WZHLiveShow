//
//  WZHLiveViewController.m
//  WZHLiveShow
//
//  Created by wszyxc on 16/8/2.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHLiveViewController.h"

#import "WZHAttentionViewController.h"
#import "WZHNewLiveViewController.h"
#import "WZHHotViewController.h"

#import <Masonry.h>


@interface WZHLiveViewController ()<UIScrollViewDelegate>

@property (weak,nonatomic) UIView * titleView;

//关注
@property (weak,nonatomic) UIButton * btnAttension;
//热门
@property (weak,nonatomic) UIButton * btnHot;
//最新
@property (weak,nonatomic) UIButton * btnNew;
//底部白线
@property (weak,nonatomic) UIView * whiteLineView;

@property (strong,nonatomic) MASConstraint * lineViewLeadingXConstraint;

@property (weak,nonatomic) UIScrollView * scrollView;

@property (assign,nonatomic) CGFloat  kLineViewMaxRunDistance;


@end




#define  kTitleViewWidth  150
#define  kTitleViewHeight  40




@implementation WZHLiveViewController

- (void)loadView{
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:DeviceFrame];
    
    self.scrollView = scrollView;
    
    self.view = scrollView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //自定义导航栏
    [self setupNav];
    
    //设置子控制器
    [self setupChildControllers];
    
    //设置scrollView
    [self setupScrollView];
    
    //计算白线最大运动距离
    self.kLineViewMaxRunDistance = (kTitleViewWidth - self.btnAttension.bounds.size.width);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupScrollView{
    
   // self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.childViewControllers.count, 0);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
  //  self.scrollView.scrollEnabled = NO;

    self.scrollView.delegate = self;
    
}


/**
 *  设置子控制器,并将子控制器的view添加到scrollView上
 */

- (void)setupChildControllers{
    
    //添加关注控制器
    WZHAttentionViewController *attentionVC = [[WZHAttentionViewController alloc]init];
    [self addChildViewController:attentionVC];
    
    [self.scrollView addSubview:attentionVC.view];
    
    
    //添加热门 控制器
    WZHHotViewController *hotVC = [[WZHHotViewController alloc]init];
    [self addChildViewController:hotVC];
    
    [self.scrollView addSubview:hotVC.view];
    
    //添加最新 控制器
    WZHNewLiveViewController *newVC = [[WZHNewLiveViewController alloc]init];
    [self addChildViewController:newVC];
    
    [self.scrollView addSubview:newVC.view];
    
    //添加scrollView的约束  上下宽高左约束(全部设满) 右边约束只设最后一个(为scrollView的trailing)
    
    [attentionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.top.bottom.equalTo(self.scrollView);
        make.size.equalTo(self.scrollView);
      //  make.trailing.equalTo(self.scrollView);
        
    }];
    
    [hotVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(attentionVC.view.mas_trailing);
        make.top.bottom.equalTo(self.scrollView);
        make.size.equalTo(self.scrollView);
      //  make.trailing.equalTo(self.scrollView.mas_trailing);
    
    }];
    
    [newVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.top.equalTo(self.scrollView);
        make.leading.equalTo(hotVC.view.mas_trailing);
        make.size.equalTo(self.scrollView);
        make.trailing.equalTo(self.scrollView.mas_trailing);
        
    }];
}



/**
 *  自定义导航栏
 */

- (void)setupNav{
    
    
    //左侧的搜索图标

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"card_search"] highImage:nil target:self action:@selector(searchClick)];
    
    //右侧的消息图标
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"card_message"] highImage:nil target:self action:@selector(messageClick)];
    
    //中间的titleView
    [self setupTitleView];
   
}

//titleView

- (void)setupTitleView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTitleViewWidth, kTitleViewHeight)];
    self.titleView = view;
    UIButton *btnAttension = [self addOneButtonWithTitle:@"关注"];
    UIButton *btnHot = [self addOneButtonWithTitle:@"热门"];
    UIButton *btnNew = [self addOneButtonWithTitle:@"最新"];
    UIView *whiteLineView = [[UIView alloc]init];
    whiteLineView.backgroundColor = [UIColor whiteColor];
    
    self.btnAttension = btnAttension;
    self.btnHot = btnHot;
    self.btnNew = btnNew;
    self.whiteLineView = whiteLineView;
    
    [btnAttension sizeToFit];
    [btnHot sizeToFit];
    [btnNew sizeToFit];
    
    [view addSubview:btnAttension];
    [view addSubview:btnHot];
    [view addSubview:btnNew];
    [view addSubview:whiteLineView];
    
    
    
    self.navigationItem.titleView = view;
    //设置约束
    [btnAttension mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.top.bottom.equalTo(view);
        
    }];
    
    [btnHot mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(view);
        make.centerX.equalTo(view.mas_centerX);
        make.width.equalTo(btnAttension);
   
    }];
    
    [btnNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.equalTo(view);

        make.width.equalTo(btnHot);
    }];
    
    [whiteLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(btnAttension);
        make.height.offset(2);
      self.lineViewLeadingXConstraint =  make.leading.equalTo(view.mas_leading).offset(2);
        make.bottom.equalTo(view.mas_bottom).offset(-5);
        
    }];
    
}

- (UIButton *)addOneButtonWithTitle:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(textViewClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return  btn;
}

//点击了中间的textView

- (void)textViewClick:(UIButton *)btn{
    
    //先解除lineView的centerX约束
    [self.lineViewLeadingXConstraint uninstall];
    
    //再更新白线的约束,并记录
    
    [self.whiteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
                self.lineViewLeadingXConstraint = make.leading.equalTo(btn.mas_leading);
            }];

    
    if ([btn.titleLabel.text isEqualToString:@"关注"]) {
        NSLog(@"点击了关注");
//        [self.whiteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
//            self.lineViewLeadingXConstraint = make.leading.equalTo(self.titleView).offset(2);
//        }];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    }else if ([btn.titleLabel.text isEqualToString:@"热门"]){
        NSLog(@"点击了热门");
//        [self.whiteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
//            self.lineViewLeadingXConstraint = make.leading.equalTo(self.titleView).offset(0.5*_kLineViewMaxRunDistance);
//        }];
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
    }else if([btn.titleLabel.text isEqualToString:@"最新"]){
        NSLog(@"点击了最新");
//        [self.whiteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
//            self.lineViewLeadingXConstraint = make.leading.equalTo(self.titleView).offset(_kLineViewMaxRunDistance);
//        }];
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth*2, 0) animated:NO];
    }
    
    //做动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.titleView  layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}


// 点击了左侧搜索

- (void)searchClick{
    
    NSLog(@"点击了搜索");
}

//点击了右侧的消息

- (void)messageClick{
    
    
    NSLog(@"点击了消息");
}


/**
 *  scrollView的代理方法
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //实时计算当前位置,实现和titleView上的按钮的联动
  
    CGFloat contentOffSetX = scrollView.contentOffset.x;

    
    //将scrollView的滑动跟白线的滑动一一对应起来
    CGFloat lineViewX = contentOffSetX / (ScreenWidth*(self.childViewControllers.count - 1)) * _kLineViewMaxRunDistance;
    
    
    //先解除lineView的centerX约束
    [self.lineViewLeadingXConstraint uninstall];
    
    //再更新白线的约束,并记录
    [self.whiteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        self.lineViewLeadingXConstraint = make.leading.equalTo(self.titleView.mas_leading).offset(lineViewX+2);
        
    }];
    
    [UIView animateWithDuration:0.05 animations:^{
       
        [self.titleView layoutIfNeeded];
        
    }];
    
}



@end
