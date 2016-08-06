//
//  SWNetWorkTools.h
//
//  Created by wszyxc on 16/7/24.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef enum : NSUInteger {
    GetDataTypeGet,
    GetDataTypePost,
} GetDataType;

@interface SWNetWorkTools :AFHTTPSessionManager

+ (instancetype)sharedTools;

- (void)requestWithType:(GetDataType)type urlString:(NSString *)urlStr parameters:(id)params finished:(void(^)(id response,NSError *error))finishBlock;

@end
