//
//  SWNetWorkTools.m
//  新浪微博 OC版
//
//  Created by wszyxc on 16/7/24.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "SWNetWorkTools.h"
#import <AFNetworking.h>



@interface SWNetWorkTools ()

//typedef void (^Myblock)(id response,NSError *error);
//
//@property (copy,nonatomic) Myblock myBlock;

@end

@implementation SWNetWorkTools


+ (instancetype)sharedTools{
    
    static SWNetWorkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SWNetWorkTools alloc]init];
        
        NSSet *set = [NSSet setWithObjects:@"text/plain", nil];
        
        instance.responseSerializer.acceptableContentTypes = set;
    
    });
    
    
    return instance;
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
