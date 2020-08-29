//
//  ZDBusinessDocument.m
//  ZDModuleKit_Example
//
//  Created by dragonLi on 14/8/2020.
//  Copyright © 2020 DevdragonLi. All rights reserved.
//

#import "ZDBusinessDocument.h"

@interface ZDBusinessDocument ()<ZDModuleProtocol>

@end

@implementation ZDBusinessDocument

+ (void)load {
    [self registerModule];
}

+ (NSInteger)priority {
    return ZDModulePriorityVeryHigh;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"文档模块 处理初始化逻辑");
    [self runAfterMethodExecuted:^{
        NSLog(@"runAfterMethodExecuted：文档模块延迟逻辑");
    }];
    return YES;
}


@end

