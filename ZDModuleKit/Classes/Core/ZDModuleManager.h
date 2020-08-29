//
//  ZDModuleManager.h
//  Pods-ZDModuleKit_Example
//
//  Created by dragonLi on 14/8/2020.
//

NS_ASSUME_NONNULL_BEGIN

@import Foundation;

@class ZDModule,ZDApplicationDelegateProxy;

@interface ZDModuleManager : NSObject

@property (strong, nonatomic, readonly) ZDApplicationDelegateProxy *proxy;

@property (strong, nonatomic, readonly) NSArray <ZDModule *> *modules;

+ (instancetype)shared;

+ (void)addModuleClass:(Class)cls;

+ (void)removeModuleClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
