//
//  QHQTabBarItemView.m
//
//  Created by lujianwen on 2018/12/4.
//  Copyright © 2018  All rights reserved.
//

#import "QHQTabBarItemView.h"
#import "UIColor+Palette.h"
#import "UIView+Addition.h"
#import "JDDeviceHelper.h"
#import "QHQTabBarBaseIconView.h"
#import "QHQTabBarIconViewFactory.h"
#import <JDAppSkinManager.h>

static CGFloat kBottomMargin = 3;
static CGFloat kTitleIconMargin = 3;

@interface QHQTabBarItemView ()

@property (nonatomic, strong) QHQTabBarBaseIconView *normalView;
@property (nonatomic, strong) QHQTabBarBaseIconView *selectedView;

@property (nonatomic, assign) kQHQTabBarItemViewStyle style;

@end

@implementation QHQTabBarItemView{
    CGSize _currentIconSize;
}

- (instancetype)initWithTabBarItem:(QHQTabBarItem *)tabBarItem
{
    self = [super init];
    if (self) {
        _tabBarItem = tabBarItem;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    _iconView = [[UIView alloc] init];
    [self addSubview:_iconView];
    
    _normalView = [QHQTabBarIconViewFactory fetchTabBarItemViewWithTabBarItem:_tabBarItem isSelected:NO];
    [_iconView addSubview:_normalView];
    
    _selectedView = [QHQTabBarIconViewFactory fetchTabBarItemViewWithTabBarItem:_tabBarItem isSelected:YES];
    [_iconView addSubview:_selectedView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.text = _tabBarItem.title;
    [self addSubview:_titleLabel];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        _titleLabel.textColor = JDAppSkinColorForKey(@"TabBarTextSelectedColor");
        _currentIconSize = _tabBarItem.selectedIconSize;
        _normalView.hidden = YES;
        _selectedView.hidden = NO;
        _selectedView.isSelected = YES;
        _style = _tabBarItem.selectedStyle;
    } else {
        _titleLabel.textColor = JDAppSkinColorForKey(@"TabBarTextNormalColor");
        _currentIconSize = _tabBarItem.normalIconSize;
        _normalView.hidden = NO;
        _selectedView.hidden = YES;
//        _normalView.isSelected = YES;//打开之后，未选中也支持所有动画效果（json、gif、视频）
        _style = _tabBarItem.normalStyle;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat bottomMargin = kBottomMargin;
    if ([JDDeviceHelper deviceScreenSizeType] == JDDeviceScreenSizeTypeXsMax ||
        [JDDeviceHelper deviceScreenSizeType] == JDDeviceScreenSizeTypeX) {
        bottomMargin = 34;
    }
    
    CGFloat centerX = CGRectGetMidX(self.bounds);
    if (_style == kQHQTabBarItemViewStyleDefault) {
        [_titleLabel sizeToFit];
        _titleLabel.frame = CGRectMake(0, 0, _titleLabel.size.width, _titleLabel.size.height);
        _titleLabel.centerX = centerX;
        _titleLabel.bottom = self.height - bottomMargin;
        _iconView.frame = CGRectMake(0, 0, _currentIconSize.width, _currentIconSize.height);
        _iconView.centerX = centerX;
        _iconView.bottom = _titleLabel.top - kTitleIconMargin;
    } else if (_style == kQHQTabBarItemViewStyleOnlyImage){
        _titleLabel.frame = CGRectZero;
        _iconView.frame = CGRectMake(0, 0, _currentIconSize.width, _currentIconSize.height);
        _iconView.centerX = centerX;
        _iconView.bottom = self.height - bottomMargin - kBottomMargin * 3;
    }  else if (_style == kQHQTabBarItemViewStyleLargeImage){
        _titleLabel.frame = CGRectZero;
        _iconView.frame = CGRectMake(0, 0, _currentIconSize.width, _currentIconSize.height);
        _iconView.centerX = centerX;
        _iconView.bottom = self.height - bottomMargin - 5;
    }
    
    _selectedView.frame = _iconView.bounds;
    _normalView.frame = _iconView.bounds;
}

- (void)clearTabBarItemViewState {
    self.isSelected = NO;
}

- (CGFloat)height {
    return [JDDeviceHelper tabBarHeight];
}

@end
