//
//  QHQTabBarItemView.m
//
//  Created by lujianwen on 2018/11/19.
//  Copyright © 2018 All rights reserved.
//

#import "QHQTabBarItemDefaultView.h"
#import "QHQResourceManager.h"
#import "UITabBar+QHQUITabBar.h"

@interface QHQTabBarItemDefaultView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation QHQTabBarItemDefaultView

- (void)setupUI {
    [super setupUI];
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
}

- (void)setContent:(id)content {
    if ([UITabBar getTabBarType] == kQHQTabBarTypeNative) {
        _imageView.image = [UIImage imageNamed:content];
        return;
    }
    _imageView.image = [UIImage imageWithData:(NSData *)content];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
}

@end
