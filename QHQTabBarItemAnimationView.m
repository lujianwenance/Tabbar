//
//  QHQTabBarItemAnimationView.m
//
//  Created by lujianwen on 2018/11/22.
//  Copyright © 2018 All rights reserved.
//

#import "QHQTabBarItemAnimationView.h"
#import <Lottie/Lottie.h>

@interface QHQTabBarItemAnimationView ()

@property (nonatomic, strong) LOTAnimationView *animationView;

@end

@implementation QHQTabBarItemAnimationView

- (void)setupUI {
    [super setupUI];
    
}

- (void)setContent:(id)content {
    
    if (_animationView) {
        [_animationView removeFromSuperview];
    }
    
    NSDictionary *dicJson = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    _animationView = [LOTAnimationView animationFromJSON:dicJson];
    [self.contentView addSubview:_animationView];
}

- (void)setIsSelected:(BOOL)isSelected {
    [super setIsSelected:isSelected];
    if (isSelected) {
        [self play];
    }
}

- (void)play {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animationView play];
    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _animationView.frame = self.contentView.bounds;
}

@end
