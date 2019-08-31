//
//  UIView+Addition.h
//
//
//  Created by lujianwen.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

/**
 *  左边距
 */
@property(nonatomic) CGFloat left;

/**
 *  上边距
 */
@property(nonatomic) CGFloat top;

/**
 *  右边距
 */
@property(nonatomic) CGFloat right;

/**
 *  下边距
 */
@property(nonatomic) CGFloat bottom;

/**
 *  宽度
 */
@property(nonatomic) CGFloat width;

/**
 *  高度
 */
@property(nonatomic) CGFloat height;

/**
 *  中心点x值
 */
@property(nonatomic) CGFloat centerX;

/**
 *  中心点y值
 */
@property(nonatomic) CGFloat centerY;

/**
 *  原点
 */
@property(nonatomic) CGPoint origin;

/**
 *  大小
 */
@property(nonatomic) CGSize size;

/**
 *  设置原点y值
 *
 *  @param originY y值
 */
- (void)setOriginY:(CGFloat)originY;

/**
 *  设置原点X值
 *
 *  @param originX x值
 */
- (void)setOriginX:(CGFloat)originX;

/**
 *  移除所有子视图
 */
- (void)removeAllSubviews;

/**
 *  移除子视图
 *
 *  @param  view 子视图
 */
- (void)removeSubview:(UIView *)view;

/**
 *  给子视图添加"填充"约束
 *
 *  @param aSubView 子视图
 *
 *  @return 返回约束(top,left,bottom,right)
 */
- (NSArray *)addConstraintForSubviewFillSuperView:(UIView *)aSubView;

/**
 *  给当前view设置部分圆角
 *
 *  @param cornerRadius 圆角半径
 *  @param corners      设置圆角的部分
 */
- (void)setCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;

@end
