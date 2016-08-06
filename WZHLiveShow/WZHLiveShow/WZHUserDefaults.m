//
//  WZHUserDefaults.m
// 01-自定义TabBarController
//
//  Created by wszyxc on 16/5/30.
//  Copyright © 2016年 wszyxc. All rights reserved.
//

#import "WZHUserDefaults.h"

@implementation WZHUserDefaults


+ (void)WZHSaveObject:(id)value forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:value forKey:key];
    
    [defaults synchronize];
    
}

+ (id)WZHObjectForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:key];
    
}

+ (NSString *)WZHStringForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults stringForKey:key];
}

+(void)WZHSaveBoolValue:(BOOL)value forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:value forKey:key];
    
    [defaults synchronize];
}

+ (BOOL)WZHBoolForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    
}



@end
