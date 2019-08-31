//
//  QHQTabBarBaseIconView.h
//
//  Created by lujianwen on 2018/12/4.
//  Copyright © 2018 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHQTabBarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QHQTabBarBaseIconView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) id content;
@property (nonatomic, assign) BOOL isSelected;

- (void)setupUI;

@end

NS_ASSUME_NONNULL_END
