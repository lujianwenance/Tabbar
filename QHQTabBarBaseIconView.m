//
//  QHQTabBarBaseIconView.m
//
//  Created by lujianwen on 2018/12/4.
//  Copyright © 2018  All rights reserved.
//

#import "QHQTabBarBaseIconView.h"

@interface QHQTabBarBaseIconView ()

@end

@implementation QHQTabBarBaseIconView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
}

- (void)setIsSelected:(BOOL)isSelected {
    //A subclass to implement this method
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.frame = self.bounds;
}

@end
