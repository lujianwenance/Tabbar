//
//  QHQTabBarItem.h
//
//  Created by lujianwen on 2018/11/19.
//  Copyright © 2018 All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


extern NSString *const kTabBarControllerForLoan;
extern NSString *const kTabBarControllerForMall;
extern NSString *const kTabBarControllerForRepay;
extern NSString *const kTabBarControllerForDiscover;
extern NSString *const kTabBarControllerForMine;


typedef NS_ENUM(NSInteger , kQHQTabBarItemViewType) {
    kQHQTabBarItemViewTypeDefault,
    kQHQTabBarItemViewTypeJson,
    kQHQTabBarItemViewTypeGif,
    kQHQTabBarItemViewTypeMovie,
    kQHQTabBarItemViewTypeNative
};

typedef NS_ENUM(NSInteger, kQHQTabBarItemViewStyle) {
    kQHQTabBarItemViewStyleDefault,
    kQHQTabBarItemViewStyleOnlyImage,
    kQHQTabBarItemViewStyleLargeImage
};

@interface QHQTabBarItem: NSObject <NSCopying, NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *normalIcon;
@property (nonatomic, copy) NSString *selectedIcon;

@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) kQHQTabBarItemViewType normalType;
@property (nonatomic, assign) kQHQTabBarItemViewType selectedType;
@property (nonatomic, assign) kQHQTabBarItemViewStyle normalStyle;
@property (nonatomic, assign) kQHQTabBarItemViewStyle selectedStyle;

@property (nonatomic, assign) CGSize normalIconSize;
@property (nonatomic, assign) CGSize selectedIconSize;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL show;

@property (nonatomic, copy) NSString *resourceName;

- (instancetype)initWithDic:(NSDictionary *)aDic;

@end



NS_ASSUME_NONNULL_END
