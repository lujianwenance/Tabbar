//
//  QHQTabBarItemView.h
//
//  Created by lujianwen on 2018/12/4.
//  Copyright © 2018  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHQTabBarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QHQTabBarItemView : UIView

@property (nonatomic, strong) QHQTabBarItem *tabBarItem;
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UIView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithTabBarItem:(QHQTabBarItem *)tabBarItem;
- (void)clearTabBarItemViewState;

- (void)setupUI;
- (CGFloat)height;

@end

NS_ASSUME_NONNULL_END
