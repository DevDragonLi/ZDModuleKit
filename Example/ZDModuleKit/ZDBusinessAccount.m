//
//  ZDBusinessAccount.m
//  ZDModuleKit_Example
//
//  Created by dragonLi on 14/8/2020.
//  Copyright © 2020 DevdragonLi. All rights reserved.
//



#import "ZDBusinessAccount.h"

#import <ZDModuleKit/ZDModuleKit.h>

@interface ZDBusinessAccount ()<ZDModuleProtocol>

@end

@implementation ZDBusinessAccount

+ (void)load {
    [self registerModule];
}

+ (NSInteger)priority {
    return ZDModulePriorityLow;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"账号业务 处理初始化逻辑");
    [self runAfterMethodExecuted:^{
        NSLog(@"runAfterMethodExecuted 账号业务延迟逻辑");
    }];
    return YES;
}



@end
