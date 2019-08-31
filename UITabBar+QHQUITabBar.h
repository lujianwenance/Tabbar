//
//  UITabBar+QHQUITabBar.h
//
//  Created by lujianwen on 2018/12/7.
//  Copyright © 2018 All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,kQHQTabBarType) {
    kQHQTabBarTypeDefault,
    kQHQTabBarTypeNative
};


@interface UITabBar (QHQUITabBar)

+ (void)tabBarType:(kQHQTabBarType)type;
+ (kQHQTabBarType)getTabBarType;

@end

NS_ASSUME_NONNULL_END
