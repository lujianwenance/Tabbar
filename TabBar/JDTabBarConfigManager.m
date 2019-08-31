//
//  JDTabBarConfigManager.m
//  JDBaseBusiness
//
//  Created by lujianwen on 2018/6/12.
//  Copyright © 2018年  All rights reserved.
//

#import "JDTabBarConfigManager.h"
#import "QHQResourceManager.h"
#import "QHQDownloadHandler.h"
#import "JDDataHandler.h"
#import "JDViewModelManager.h"

#define TabBarFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"tabBar.data"]

NSString *const JDSwitchShowTypeOn = @"10";
NSString *const JDSwitchShowTypeOff = @"20";

@interface JDTabBarConfigManager ()

@property (nonatomic, readwrite) QHQTabBarModel *tabBarModel;
@property (nonatomic, strong) NSArray *tabBarResourceNames;

@end

@implementation JDTabBarConfigManager

+ (instancetype)sharedManager {
    static JDTabBarConfigManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JDTabBarConfigManager alloc] init];
    });
    return _manager;
}

- (void)setTabBarModels:(NSArray *)tabBarModels {
    _tabBarModels = tabBarModels;
    NSMutableArray *resourceNames = [NSMutableArray array];
    for (QHQTabBarModel *model in tabBarModels) {
        [QHQDownloadHandler downloadTabBarResourceWithUrl:model.resourceUrl md5:model.md5 completion:nil];
        [resourceNames addObject:model.resourceName];
    }
    self.tabBarResourceNames = [resourceNames copy];
    [self checkTabBarModel];
    [self deleteAndSaveResourceIfNeeded];
}

- (void)setTabBarModel:(QHQTabBarModel *)tabBarModel {
    _tabBarModel = tabBarModel;
    _tabBarModel.tabItems = [tabBarModel.tabItems sortedArrayUsingComparator:^NSComparisonResult(QHQTabBarItem * _Nonnull obj1, QHQTabBarItem *  _Nonnull obj2) {
        if (obj1.index < obj2.index) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
}

- (BOOL)isCachedTabBarModel {
    return _tabBarModel != nil;
}

- (NSArray *)defaultTabBarItems {
    NSMutableArray *items = [NSMutableArray array];
    QHQTabBarItem *homeItem = [[QHQTabBarItem alloc] init];
    homeItem.title = JDViewTypeStringForKey(@"tabbar", @"homeTab")?:@"借款";
    homeItem.normalIcon = @"tab_loan";
    homeItem.selectedIcon = @"tab_loan_pressed";
    homeItem.normalIconSize = CGSizeMake(24, 24);
    homeItem.selectedIconSize = CGSizeMake(24, 24);
    homeItem.code = kTabBarControllerForLoan;
    homeItem.show = YES;
    homeItem.index = 0;
    
    QHQTabBarItem *mallItem = [[QHQTabBarItem alloc] init];
    mallItem.title = @"商城";
    mallItem.normalIcon = @"tab_mall";
    mallItem.selectedIcon = @"tab_mall_pressed";
    mallItem.normalIconSize = CGSizeMake(24, 24);
    mallItem.selectedIconSize = CGSizeMake(24, 24);
    mallItem.show = NO;
    mallItem.index = 1;
    
    QHQTabBarItem *billItem = [[QHQTabBarItem alloc] init];
    billItem.title = JDViewTypeStringForKey(@"tabbar", @"repayTab")?:@"还款";
    billItem.normalIcon = @"tab_repay";
    billItem.selectedIcon = @"tab_repay_pressed";
    billItem.normalIconSize = CGSizeMake(24, 24);
    billItem.selectedIconSize = CGSizeMake(24, 24);
    billItem.code = kTabBarControllerForRepay;
    billItem.show = YES;
    billItem.index = 2;
    
    QHQTabBarItem *discoverItem = [[QHQTabBarItem alloc] init];
    discoverItem.title = @"发现";
    discoverItem.normalIcon = @"tab_discover";
    discoverItem.selectedIcon = @"tab_discover_pressed";
    discoverItem.normalIconSize = CGSizeMake(24, 24);
    discoverItem.selectedIconSize = CGSizeMake(24, 24);
    discoverItem.code = kTabBarControllerForDiscover;
    discoverItem.show = NO;
    discoverItem.index = 3;
    
    QHQTabBarItem *mineItem = [[QHQTabBarItem alloc] init];
    mineItem.title = JDViewTypeStringForKey(@"tabbar", @"mineTab")?:@"我的";
    mineItem.normalIcon = @"tab_mine";
    mineItem.selectedIcon = @"tab_mine_pressed";
    mineItem.normalIconSize = CGSizeMake(24, 24);
    mineItem.selectedIconSize = CGSizeMake(24, 24);
    mineItem.code = kTabBarControllerForMine;
    mineItem.show = YES;
    mineItem.index = 4;
    
    [items addObject:homeItem];
    [items addObject:mallItem];
    [items addObject:billItem];
    [items addObject:discoverItem];
    [items addObject:mineItem];
    
    return [items copy];
}

- (void)checkTabBarModel {
    if (_tabBarModels && _tabBarModels.count == 1) {
        QHQTabBarModel *tabBarModel = [_tabBarModels firstObject];
        if ([QHQResourceManager isExistsOfTabBarResourceWithName:tabBarModel.resourceName] || [self checkTabBarItemTypeisJsonType:tabBarModel]) {
            self.tabBarModel = tabBarModel;
        }
         return;
    }
    
    BOOL checkout = NO;
    for (int i = 1; i < _tabBarModels.count; i++) {
        QHQTabBarModel *model = _tabBarModels[i];
        if ([model checkDateForShow]) {
            checkout = YES;
            if ([QHQResourceManager isExistsOfTabBarResourceWithName:model.resourceName] || [self checkTabBarItemTypeisJsonType:model]) {
                self.tabBarModel = model;
            }
            return;
        }
    }
    
    if (!checkout) {
        QHQTabBarModel *tabBarModel = [_tabBarModels firstObject];
        if ([QHQResourceManager isExistsOfTabBarResourceWithName:tabBarModel.resourceName] || [self checkTabBarItemTypeisJsonType:tabBarModel]) {
            self.tabBarModel = tabBarModel;
        }
    }
}

- (BOOL)checkTabBarItemTypeisJsonType:(QHQTabBarModel *)model {
    NSInteger jsonTypeCount = 0;
    for (QHQTabBarItem *item in model.tabItems) {
        if (item.selectedType == kQHQTabBarItemViewTypeJson && item.normalType == kQHQTabBarItemViewTypeJson) {
            jsonTypeCount++;
        }
    }
    return jsonTypeCount != 0 && jsonTypeCount == model.tabItems.count;
}

- (void)deleteAndSaveResourceIfNeeded {
    [QHQResourceManager removeFilesWithPath:[DocumentDirectoryPath stringByAppendingPathComponent:TabBarResourcePath] ignoreFileNames:self.tabBarResourceNames];
    [JDDataHandler asyncArchiveObject:_tabBarModels toPath:TabBarFilePath completion:^(BOOL success) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SaveTabBarResource];
    }];
}

@end
