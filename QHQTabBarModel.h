//
//  QHQTabBarModel.h
//
//  Created by lujianwen on 2018/12/5.
//  Copyright © 2018  All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *SaveTabBarResource;

@interface QHQTabBarModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *resourceUrl;
@property (nonatomic, copy) NSString *md5;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, copy) NSString *resourceName;

@property (nonatomic, strong) NSArray *tabItems;

- (instancetype)initWithDic:(NSDictionary *)dic;

- (BOOL)checkDateForShow;

@end

NS_ASSUME_NONNULL_END
