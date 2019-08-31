//
//  QHQTabBarItemMovieView.m
//
//  Created by lujianwen on 2018/11/26.
//  Copyright © 2018 All rights reserved.
//

#import "QHQTabBarItemMovieView.h"
#import <AVFoundation/AVFoundation.h>
#import "QHQPlayerView.h"

@interface QHQTabBarItemMovieView ()

@property (nonatomic, strong) QHQPlayerView *playerView;

@end

@implementation QHQTabBarItemMovieView

- (void)setupUI {
    [super setupUI];
    _playerView = [[QHQPlayerView alloc] init];
    _playerView.type = kQHQPlayerViewResourceTypeNative;
    [self.contentView addSubview:_playerView];
}

- (void)setContent:(id)content {
    _playerView.path = (NSString *)content;
}

- (void)setIsSelected:(BOOL)isSelected {
    [super setIsSelected:isSelected];
    if (isSelected) {
        [_playerView play];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _playerView.frame = self.contentView.bounds;
}

@end
