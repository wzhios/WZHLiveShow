//
//  WZHUserDefaults.h
//-自定义TabBarController
//
//  Created by wszyxc on 16/5/30.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZHUserDefaults : NSObject


/**
 *  从用户偏好中快速取值
 */
+ (id)WZHObjectForKey:(NSString *)key;
/**
 *  将值快速存入用户偏好
 */
+ (void)WZHSaveObject:(id)value forKey:(NSString *)key;

/**
 *  用户偏好中快速取出字符串
 */
+ (NSString *)WZHStringForKey:(NSString *)key;


/**
 *  从偏好设置中快速取出BOOL值和存储BOOL值
 */
+ (BOOL)WZHBoolForKey:(NSString *)key;

+ (void)WZHSaveBoolValue:(BOOL)value forKey:(NSString *)key;







@end
