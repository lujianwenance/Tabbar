//
//  UITabBar+QHQUITabBar.m
//
//  Created by lujianwen on 2018/12/7.
//  Copyright © 2018 All rights reserved.
//

#import "UITabBar+QHQUITabBar.h"

static kQHQTabBarType tabBarType;

@implementation UITabBar (QHQUITabBar)

+ (void)tabBarType:(kQHQTabBarType)type {
    tabBarType = type;
}

+ (kQHQTabBarType)getTabBarType {
    return tabBarType;
}

@end
