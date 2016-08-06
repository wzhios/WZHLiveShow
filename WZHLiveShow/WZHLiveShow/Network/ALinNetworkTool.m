//
//  ALinNetworkTool.m
//  MiaowShow
//
//  Created by ALin on 16/6/14.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "ALinNetworkTool.h"

@implementation ALinNetworkTool
static ALinNetworkTool *_manager;
+ (instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [ALinNetworkTool manager];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}

// 判断网络类型
+ (NetworkStates)getNetworkStates
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    //无网模式
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                {
                    states = NetworkStatesWIFI;
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return states;
}




- (void)requestWithType:(GetDataType)type urlString:(NSString *)urlStr parameters:(id)params finished:(void(^)(id response,NSError *error))finishBlock{
    
    
    AFHTTPSessionManager *mng = [[AFHTTPSessionManager alloc]init];
    
    [mng GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishBlock(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishBlock(nil,error);
    }];
    
    
}


@end
