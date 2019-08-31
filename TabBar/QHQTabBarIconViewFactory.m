//
//  QHQTabBarItemViewFactory.m
//
//  Created by lujianwen on 2018/11/21.
//  Copyright © 2018 All rights reserved.
//

#import "QHQTabBarIconViewFactory.h"
#import "QHQTabBarBaseIconView.h"
#import "QHQTabBarItemDefaultView.h"
#import "QHQTabBarItemAnimationView.h"
#import "QHQTabBarItemMovieView.h"
#import "QHQTabBarItemGifView.h"
#import "QHQResourceManager.h"
#import "UITabBar+QHQUITabBar.h"

@implementation QHQTabBarIconViewFactory

+ (QHQTabBarBaseIconView *)fetchTabBarItemViewWithTabBarItem:(QHQTabBarItem *)tabBarItem isSelected:(BOOL)isSelected {
    QHQTabBarBaseIconView *baseView = nil;
    kQHQTabBarItemViewType type = isSelected ? tabBarItem.selectedType : tabBarItem.normalType;
    
    if ([UITabBar getTabBarType] == kQHQTabBarTypeNative) {
        type = kQHQTabBarItemViewTypeNative;
    }
    
    switch (type) {
        case kQHQTabBarItemViewTypeDefault:
        {
            baseView = [[QHQTabBarItemDefaultView alloc] init];
            if (isSelected) {
                [baseView setContent:[QHQResourceManager fetchTabBarResourceWithFileName:tabBarItem.selectedIcon inFolder:tabBarItem.resourceName]];
            } else {
                [baseView setContent:[QHQResourceManager fetchTabBarResourceWithFileName:tabBarItem.normalIcon inFolder:tabBarItem.resourceName]];
            }
        }
            break;
        case kQHQTabBarItemViewTypeJson:
        {
            baseView = [[QHQTabBarItemAnimationView alloc] init];
            if (isSelected) {
                [baseView setContent:tabBarItem.selectedIcon];
            } else {
                [baseView setContent:tabBarItem.normalIcon];
            }
        }
            break;
        case kQHQTabBarItemViewTypeGif:
        {
            baseView = [[QHQTabBarItemGifView alloc] init];
            if (isSelected) {
                [baseView setContent:[QHQResourceManager fetchTabBarResourceWithFileName:tabBarItem.selectedIcon inFolder:tabBarItem.resourceName]];
            } else {
                [baseView setContent:[QHQResourceManager fetchTabBarResourceWithFileName:tabBarItem.normalIcon inFolder:tabBarItem.resourceName]];
            }
        }
            break;
        case kQHQTabBarItemViewTypeMovie:
        {
            baseView = [[QHQTabBarItemMovieView alloc] init];
            if (isSelected) {
                [baseView setContent:[QHQResourceManager getTabBarResourcePathWithFileName:tabBarItem.selectedIcon inFolder:tabBarItem.resourceName]];
            } else {
                [baseView setContent:[QHQResourceManager getTabBarResourcePathWithFileName:tabBarItem.normalIcon inFolder:tabBarItem.resourceName]];
            }
        }
            break;
        case kQHQTabBarItemViewTypeNative:
        {
            baseView = [[QHQTabBarItemDefaultView alloc] init];
            if (isSelected) {
                [baseView setContent:tabBarItem.selectedIcon];
            } else {
                [baseView setContent:tabBarItem.normalIcon];
            }
        }
            break;
    }
    return baseView;
}

@end
