//
//  UITabBarItem+JDTabBarItem.m
//  DanHuaHua
//
//  Created by lujianwen on 2018/7/24.
//  Copyright © 2018年 JinDanFenQi. All rights reserved.
//

#import "UITabBarItem+JDTabBarItem.h"
#import <UIViewController+CYLTabBarControllerExtention.h>
#import <CYLTabBarController.h>
#import "JDTabBarControllerConfig.h"
#import "QHQTabBarItemView.h"
#import <UIImage+Tint.h>
#import <objc/runtime.h>
#import <Masonry.h>

@interface JDTabBarItemTool : NSObject

@end

@implementation JDTabBarItemTool

+ (void)exchangeClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod([class class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([class class], swizzledSelector);
    BOOL addSuccessed = class_addMethod([class class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(swizzledMethod));
    if (!addSuccessed) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    } else {
        class_replaceMethod([class class],
                            method_getName(originalMethod),
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
    }
}

@end

static const void *kJDTabBarItemAnimationName = &kJDTabBarItemAnimationName;
static const void *kJDTabBarItemOriImageName = &kJDTabBarItemOriImageName;
static const void *kJDTabBarItem = &kJDTabBarItem;

@interface UITabBarItem (AnimationName)

@property (nonatomic, copy) NSString *animationName;
@property (nonatomic, copy) NSString *oriImageName;
@property (nonatomic, strong) QHQTabBarItem *item;

@end

@implementation UITabBarItem (AnimationName)

- (void)setAnimationName:(NSString *)animationName {
    objc_setAssociatedObject(self, kJDTabBarItemAnimationName, animationName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)animationName{
    return objc_getAssociatedObject(self, kJDTabBarItemAnimationName);
}

- (void)setOriImageName:(NSString *)oriImageName {
    objc_setAssociatedObject(self, kJDTabBarItemOriImageName, oriImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)oriImageName {
    return objc_getAssociatedObject(self, kJDTabBarItemOriImageName);
}

- (void)setItem:(QHQTabBarItem *)item {
    objc_setAssociatedObject(self, kJDTabBarItem, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QHQTabBarItem *)item {
    return objc_getAssociatedObject(self, kJDTabBarItem);
}

@end



static const void *JDTabBarItemContentIdentifier = &JDTabBarItemContentIdentifier;
static const void *JDTabBarItemSelectedIndex = &JDTabBarItemSelectedIndex;
static const void *JDTabBarItemNeedSave = &JDTabBarItemNeedSave;
static const void *JDTabBarItemContentView = &JDTabBarItemContentView;
static const void *JDTabBarItemItemViews = &JDTabBarItemItemViews;
static const void *JDTabBarItemControlls = &JDTabBarItemControlls;

@interface UITabBar (Identifier)

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL needSaveAnimationView;

@property (nonatomic, strong) NSMutableArray *itemViews;
@property (nonatomic, strong) NSMutableArray *controlls;

@end

@implementation UITabBar (Identifier)

- (void)setIdentifier:(NSString *)identifier {
    objc_setAssociatedObject(self, JDTabBarItemContentIdentifier, identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)identifier {
    return objc_getAssociatedObject(self, JDTabBarItemContentIdentifier);
}

- (void)setContentView:(UIView *)contentView {
    objc_setAssociatedObject(self, JDTabBarItemContentView, contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)contentView {
    return objc_getAssociatedObject(self, JDTabBarItemContentView);
}

- (void)setItemViews:(NSMutableArray *)itemViews {
    objc_setAssociatedObject(self, JDTabBarItemItemViews, itemViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)itemViews {
    return objc_getAssociatedObject(self, JDTabBarItemItemViews);
}

- (void)setControlls:(NSMutableArray *)controlls {
    objc_setAssociatedObject(self, JDTabBarItemControlls, controlls, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)controlls {
    return objc_getAssociatedObject(self, JDTabBarItemControlls);
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    objc_setAssociatedObject(self, JDTabBarItemSelectedIndex, @(selectedIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)selectedIndex {
    return [objc_getAssociatedObject(self, JDTabBarItemSelectedIndex) integerValue];
}

- (void)setNeedSaveAnimationView:(BOOL)needSaveAnimationView {
    objc_setAssociatedObject(self, JDTabBarItemNeedSave, @(needSaveAnimationView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)needSaveAnimationView {
    return [objc_getAssociatedObject(self, JDTabBarItemNeedSave) integerValue];
}

@end


@implementation JDTabBarItemView

- (instancetype)initWithTabBarItem:(UITabBarItem *)item
{
    self = [super init];
    if (self) {
        
        _item = item;
        
        if (item.animationName.length > 20) {
            NSDictionary *dicJson = [NSJSONSerialization JSONObjectWithData:[item.animationName dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            _animationView = [LOTAnimationView animationFromJSON:dicJson];
        } else {
            _animationView = [LOTAnimationView animationNamed:item.animationName];
        }
        [_animationView stop];
        [self addSubview:_animationView];
        
        if (item.oriImageName.length > 20) {
            NSDictionary *dicJson = [NSJSONSerialization JSONObjectWithData:[item.oriImageName dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            _defaultView = [LOTAnimationView animationFromJSON:dicJson];
        } else {
            _defaultView = [LOTAnimationView animationNamed:item.oriImageName];
        }
        [self addSubview:_defaultView];
        [self setupConstraints];
    }
    return self;
}

- (void)setState:(JDTabBarItemViewState)state {
    _state = state;
    if (state == kJDTabBarItemViewStateNormal) {
        _animationView.hidden = YES;
        _defaultView.hidden = NO;
    } else {
        _animationView.hidden = NO;
        _defaultView.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_animationView play];
        });
    }
}

- (void)setupConstraints {
    [_animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    [_defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}

@end


@implementation UITabBarItem (JDTabBarItem)

+ (void)load {
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(setTitle:) swizzledSelector:@selector(_setTitle:)];
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(setImage:) swizzledSelector:@selector(_setImage:)];
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(setSelectedImage:) swizzledSelector:@selector(_setSelectedImage:)];
}

- (void)_setTitle:(NSString *)title {
    [self _setTitle:@""];
}

- (void)_setImage:(UIImage *)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self _setImage:image];
    } else if ([image isKindOfClass:[NSString class]]) {
        self.oriImageName = (NSString *)image;
    } else if([image isKindOfClass:[QHQTabBarItem class]]) {
        self.item = (QHQTabBarItem *)image;
    }
}

- (void)_setSelectedImage:(UIImage *)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self _setSelectedImage:image];
    } else if ([image isKindOfClass:[NSString class]]) {
        self.animationName = (NSString *)image;
    }
}

@end

@implementation UITabBar (JDTabBar)

+ (void)load {
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(setItems:animated:) swizzledSelector:@selector(_setItems:animated:)];
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(layoutSubviews) swizzledSelector:@selector(_layoutSubviews)];
}

- (void)_setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated {
    [self filterTabBarItem:items];
    [self _setItems:items animated:animated];
    if ([self getItemViews]) {
        [self.itemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.itemViews removeAllObjects];
        [self.controlls removeAllObjects];
    }
    for (int i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        QHQTabBarItemView *itemView = [[QHQTabBarItemView alloc] initWithTabBarItem:item.item];
        itemView.isSelected = (i == self.selectedIndex);
        [self.itemViews addObject:itemView];
    }
}

- (void)filterTabBarItem:(NSArray *)items {
    for (UITabBarItem *item in items) {
        UIImage *image = [self createImageWithColor:[UIColor clearColor] width:24];
        item.selectedImage = image;
        item.image = image;
    }
}

- (UIImage*)createImageWithColor:(UIColor*)color width:(CGFloat)width{
    CGRect rect=CGRectMake(0.0f, 0.0f, width, width);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)saveAnimationView {
    static int count = 0;
    NSMutableArray *containItemView = [NSMutableArray array];
    for (int i = 0; i < self.subviews.count; i++) {
        UIControl *tabBarButton = self.subviews[i];
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [self.controlls addObject:tabBarButton];
            
            if ([self containTabBarItemView:tabBarButton.subviews]) {
                [containItemView addObject:[tabBarButton.subviews firstObject]];
                break;
            }
            
            QHQTabBarItemView *itemView = nil;
            NSUInteger index = [self indexOfItemViewsWithArray:containItemView];
            if ( index != NSNotFound) {
                itemView = self.itemViews[index];
            } else if ([self containTabBarItemView:tabBarButton.subviews]) {
                itemView = [tabBarButton.subviews firstObject];
            } else {
                itemView = self.itemViews[count];
            }
            itemView.frame = tabBarButton.bounds;
            [tabBarButton addSubview:itemView];
            count++;
        }
    }
    count = 0;
}

- (BOOL)containTabBarItemView:(NSArray *)subviews {
    for (UIView *view in subviews) {
        if ([view isKindOfClass:[QHQTabBarItemView class]]) {
            return YES;
        }
    }
    return NO;
}

- (NSUInteger)indexOfItemViewsWithArray:(NSMutableArray *)array {
    if (array.count == 0) {
        return NSNotFound;
    }
    
    __block NSUInteger index = NSNotFound;
    [self.itemViews enumerateObjectsUsingBlock:^(QHQTabBarItemView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (array.count >= idx && obj != array[idx]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

- (void)_layoutSubviews {
    [self _layoutSubviews];
    [self saveAnimationView];
}

- (BOOL)getItemViews {
    if (!self.itemViews) {
        self.itemViews = [NSMutableArray array];
        self.controlls = [NSMutableArray array];
        return NO;
    }
    return YES;
}


@end

@implementation CYLTabBar (JDTabBar)

+ (void)load {
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(hitTest:withEvent:) swizzledSelector:@selector(_hitTest:withEvent:)];
}

- (UIView *)_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [self _hitTest:point withEvent:event];
    if (result) {
        return result;
    }
    
    BOOL canNotResponseEvent = self.hidden || (self.alpha <= 0.01f) || (self.userInteractionEnabled == NO) || (!self.superview) || self.frame.size.width == 0 || self.frame.size.height == 0;
    if (canNotResponseEvent) {
        return nil;
    }
    
    if (self.clipsToBounds && ![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    for (UIView *subview in self.subviews.reverseObjectEnumerator) {
        for (UIView *innerSubview in subview.subviews.reverseObjectEnumerator) {
            for (UIView *innerView in innerSubview.subviews.reverseObjectEnumerator) {
                CGPoint subInnerPoint = [innerView convertPoint:point fromView:self];
                result = [innerView hitTest:subInnerPoint withEvent:event];
                if (result) {
                    return subview;
                }
            }
        }
    }
    return nil;
}
@end


@interface CYLTabBarController (Swizzled)

@end

@implementation CYLTabBarController (Swizzled)

+ (void)load {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(getImageFromImageInfo:) swizzledSelector:@selector(_getImageFromImageInfo:)];
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(didSelectControl:) swizzledSelector:@selector(_didSelectControl:)];
#pragma clang diagnostic pop
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(setSelectedIndex:) swizzledSelector:@selector(_setSelectedIndex:)];
}

- (UIImage *)_getImageFromImageInfo:(id)imageInfo {
    UIImage *image = [self _getImageFromImageInfo:imageInfo];
    if (image) {
        return image;
    } else {
        return imageInfo;
    }
}

- (void)_setSelectedIndex:(NSUInteger)selectedIndex {
    [self _setSelectedIndex:selectedIndex];
    self.tabBar.selectedIndex = selectedIndex;
    [self _didSelectControl:[self.tabBar.controlls objectAtIndex:selectedIndex]];
}

- (void)_didSelectControl:(UIControl *)control {
    self.tabBar.selectedIndex = [self.tabBar.controlls indexOfObject:control];
    [self _didSelectControl:control];
}

@end



@interface JDTabBarControllerConfig (Swizzled)

@end

@implementation JDTabBarControllerConfig (Swizzled)

+ (void)load {
    [JDTabBarItemTool exchangeClass:self originalSelector:@selector(tabBarController:didSelectControl:) swizzledSelector:@selector(_tabBarController:didSelectControl:)];
}

- (void)_tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
    if (self.tabBarController.tabBar.selectedIndex != 0 && ![JDUserManager sharedInstance].isLogin) {
        return;
    }
    
    [self _tabBarController:tabBarController didSelectControl:control];
    
    for (int i = 0; i < control.subviews.count; i++) {
        UIView *view = control.subviews[i];
        if ([view isKindOfClass:NSClassFromString(@"QHQTabBarItemView")]) {
            QHQTabBarItemView *item = (QHQTabBarItemView *)view;
            item.isSelected = YES;
        }
    }
    
    for (UIControl *controlItem in tabBarController.tabBar.subviews) {
        if ([controlItem isKindOfClass:NSClassFromString(@"UITabBarButton")] && controlItem != control) {
            for (UIView *view in controlItem.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"QHQTabBarItemView")]) {
                    QHQTabBarItemView *item = (QHQTabBarItemView *)view;
                    item.isSelected = NO;
                }
            }
        }
    }
}


@end




