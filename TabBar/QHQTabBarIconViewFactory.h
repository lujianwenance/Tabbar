//
//  QHQTabBarItemViewFactory.h
//
//  Created by lujianwen on 2018/11/21.
//  Copyright © 2018 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHQTabBarItem.h"

@class QHQTabBarBaseIconView;

NS_ASSUME_NONNULL_BEGIN

@interface QHQTabBarIconViewFactory : NSObject

+ (QHQTabBarBaseIconView *)fetchTabBarItemViewWithTabBarItem:(QHQTabBarItem *)tabBarItem isSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
