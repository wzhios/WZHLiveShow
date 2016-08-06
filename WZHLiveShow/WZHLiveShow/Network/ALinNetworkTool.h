//
//  ALinNetworkTool.h
//  MiaowShow
//
//  Created by ALin on 16/6/14.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum : NSUInteger {
    GetDataTypeGet,
    GetDataTypePost,
} GetDataType;

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};

@interface ALinNetworkTool : AFHTTPSessionManager
+ (instancetype)shareTool;

// 判断网络类型
+ (NetworkStates)getNetworkStates;


- (void)requestWithType:(GetDataType)type urlString:(NSString *)urlStr parameters:(id)params finished:(void(^)(id response,NSError *error))finishBlock;

@end
