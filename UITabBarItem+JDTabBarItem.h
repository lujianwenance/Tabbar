//
//  UITabBarItem+JDTabBarItem.h
//
//  Created by lujianwen on 2018/7/24.
//  Copyright © 2018年  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Lottie/Lottie.h>
#import <CYLTabBar.h>

@interface UITabBarItem (JDTabBarItem)

@end


@interface UITabBar (JDTabBar)

@end


@interface CYLTabBar (JDTabBar)

@end

typedef NS_ENUM(NSInteger , JDTabBarItemViewState) {
    kJDTabBarItemViewStateNormal,
    kJDTabBarItemViewStateSelected
};

@interface JDTabBarItemView : UIView

@property (nonatomic, strong) UITabBarItem *item;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) LOTAnimationView *animationView;
@property (nonatomic, strong) LOTAnimationView *defaultView;

@property (nonatomic, assign) JDTabBarItemViewState state;

@end
