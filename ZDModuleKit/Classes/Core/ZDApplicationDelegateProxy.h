//
//  ZDApplicationDelegateProxy.h
//  ZDModuleKit
//
//  Created by dragonLi on 14/8/2020.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ZDApplicationDelegateProxy : NSObject

@property (strong, nonatomic) id <UIApplicationDelegate> realDelegate;

@end

NS_ASSUME_NONNULL_END
