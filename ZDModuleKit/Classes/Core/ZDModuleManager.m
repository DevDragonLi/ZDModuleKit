//
//  ZDModuleManager.m
//  Pods-ZDModuleKit_Example
//
//  Created by dragonLi on 14/8/2020.
//


@import ObjectiveC.runtime;

@import UIKit;

#import "ZDModuleManager.h"

#import "ZDModule.h"

#import "ZDApplicationDelegateProxy.h"

@interface ZDModuleManager()

@property (strong, nonatomic) ZDApplicationDelegateProxy *proxy;

@property (strong, nonatomic) NSMutableArray <ZDModule *> *mModules;

@property (strong, nonatomic) NSMutableArray *moduleClassArray;

@end

@implementation ZDModuleManager

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static ZDModuleManager *singleton = nil;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
        singleton.moduleClassArray = [NSMutableArray array];
    });
    return singleton;
}

+ (void)addModuleClass:(Class)cls {
    
    NSParameterAssert(cls && [cls isSubclassOfClass:[ZDModule class]]);
    
    [[ZDModuleManager shared].moduleClassArray addObject:cls];
}

+ (void)removeModuleClass:(Class)cls {
    [[ZDModuleManager shared].moduleClassArray  removeObject:cls];
}

- (void)generateRegistedModules {
    [self.mModules removeAllObjects];
    
    [[ZDModuleManager shared].moduleClassArray sortUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"priority" ascending:NO]]];
    
    for (Class cls in [ZDModuleManager shared].moduleClassArray) {
        ZDModule *module = [cls module];
        NSAssert(module, @"module can't be nil of class %@", NSStringFromClass(cls));
        
        if (![self.mModules containsObject:module]) {
            [self.mModules addObject:module];
        }
    }
}

- (ZDApplicationDelegateProxy *)proxy {
    if (!_proxy) {
        _proxy = [[ZDApplicationDelegateProxy alloc] init];
    }
    
    return _proxy;
}

- (NSArray<ZDModule *> *)modules {
    return (NSArray<ZDModule *> *)self.mModules;
}

- (NSMutableArray<ZDModule *> *)mModules {
    if (!_mModules) {
        _mModules = [NSMutableArray array];
    }
    
    return _mModules;
}
@end

static void zd_SwizzleInstanceMethod(Class cls, SEL originalSelector, Class targetCls, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(targetCls, swizzledSelector);
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@implementation UIApplication (ZDModule)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zd_SwizzleInstanceMethod(self, @selector(setDelegate:), self, @selector(zd_setDelegate:));
    });
}

- (void)zd_setDelegate:(id <UIApplicationDelegate>)delegate {
    ZDModuleManager.shared.proxy.realDelegate = delegate;
    [ZDModuleManager.shared generateRegistedModules];
    
    [self zd_setDelegate:(id <UIApplicationDelegate>)ZDModuleManager.shared.proxy];
}

@end
