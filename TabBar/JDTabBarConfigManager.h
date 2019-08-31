//
//  JDTabBarConfigManager.h
//  JDBaseBusiness
//
//  Created by lujianwen on 2018/6/12.
//  Copyright © 2018年 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHQTabBarItem.h"
#import "QHQTabBarModel.h"

extern NSString *const JDSwitchShowTypeOn;
extern NSString *const JDSwitchShowTypeOff;

@interface JDTabBarConfigManager : NSObject

@property (nonatomic, readonly) QHQTabBarModel *tabBarModel;
@property (nonatomic, strong) NSArray *tabBarModels;

@property (nonatomic, copy) NSString *isShow;      //!< 10开启 20关闭

+ (instancetype)sharedManager;

//- (void)getCacheImagesWithCompletion:(void (^)(NSDictionary *imagesDic))completion;
- (BOOL)isCachedTabBarModel;
- (NSArray *)defaultTabBarItems;

@end
