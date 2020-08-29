//
//  ZDModule.h
//  ZDModuleKit
//
//  Created by dragonLi on 14/8/2020.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN


/// 组件模块遵守此协议

@protocol ZDModuleProtocol <UIApplicationDelegate>

/**
 KeyWindow显示完成
 */
- (void)applicationKeyWindowVisible;

@end

/**
 模块优先级
 
 安排给弱业务，业务模块

 - ZDModulePriorityVeryLow: 极底
 
 - ZDModulePriorityLow: 低
 
 - ZDModulePriorityMedium: 中
 - ZDModulePriorityHigh: 高
 - ZDModulePriorityVeryHigh: 极高
 
 安排给基础模块（有些基础模块每次依赖都需要手动调用初始化方法，建议分成 Core / Initializer subspec，后者中只有一个类继承ZDModule，这样直接依赖模块时，初始化代码的编写就可以去掉了）
 
 这种情况下，ZDModule子类中，最好不要存在硬编码，使用变量或配置文件配置，这样才能让各业务线通用
 
 */
typedef NS_ENUM(NSInteger, ZDModulePriority) {
    ZDModulePriorityVeryLow = 25,
    ZDModulePriorityLow = 50,
    ZDModulePriorityMedium = 100,
    ZDModulePriorityHigh = 150,
    ZDModulePriorityVeryHigh = 175,
};

@interface ZDModule : NSObject

+ (instancetype)module;

/**
 在 load 中调用，以注册模块
 */
+ (void)registerModule;

/**
 模块优先级
 
 主工程模块的调用最先进行，剩余附属模块
 内部会根据优先级，依次调用 UIApplicationDelegate 代理
 默认是 ZDModulePriorityMedium
 
 @return 优先级
 */
+ (NSInteger)priority;

/**
 在调用方法执行完成之后执行 block
 
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self runAfterMethodExecuted:^{
        // 创建 windows
    }];
    return YES;
 }
 
 某些操作只能在系统声明周期执行完成之后才执行，比如创建 level 比较高的 window，需要设置 root vc，（可能会和原 root vc 冲突）
 这时候就需要将操作放入下面 block 中
 
 推荐对顺序不敏感，对系统调用返回值不影响的操作都放在这个方法的 block 参数中
 */
- (void)runAfterMethodExecuted:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
