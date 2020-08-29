//
//  ZDModule.m
//  ZDModuleKit
//
//  Created by dragonLi on 14/8/2020.
//

#import "ZDModule.h"
#import "ZDModuleManager.h"

@implementation ZDModule

- (instancetype)init {
    if (self = [super init]) {
        if (![self conformsToProtocol:@protocol(ZDModuleProtocol)]) {
            @throw [NSException exceptionWithName:@"ZDModuleRegisterProgress" reason:@"subclass should confirm to <ZDModuleProtocol>." userInfo:nil];
        }
    }
    
    return self;
}

+ (instancetype)module {
    return [[self alloc] init];
}

+ (void)registerModule {
    // https://developer.apple.com/documentation/objectivec/nsobject/1418815-load?preferredLanguage=occ
    // In a custom implementation of load you can therefore safely message other unrelated classes from the same image, but any load methods implemented by those classes may not have run yet.
    // load 之前，同一个 image 中的所有 class 都是已知的，所以可以调用
    
    [ZDModuleManager addModuleClass:self];
    
}

+ (NSInteger)priority {
    return ZDModulePriorityMedium;
}

+ (void)delayTaskWithBlock:(void (^)(void))block {
    dispatch_async(dispatch_get_main_queue(), ^{
        !block ?: block();
    });
}


@end
