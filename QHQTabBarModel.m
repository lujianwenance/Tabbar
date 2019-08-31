//
//  QHQTabBarModel.m
//
//  Created by lujianwen on 2018/12/5.
//  Copyright © 2018  All rights reserved.
//

#import "QHQTabBarModel.h"
#import "QHQTabBarItem.h"

NSString const* SaveTabBarResource = @"saveTabBarResource";

@implementation QHQTabBarModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _resourceUrl = dic[@"resourceUrl"];
        _md5 = dic[@"md5"];
        _startDate = dic[@"startDate"];
        _endDate = dic[@"endDate"];
        _resourceName = [_resourceUrl lastPathComponent].stringByDeletingPathExtension;
        NSMutableArray *tabBarItems = [NSMutableArray array];
        for (NSDictionary *tabDic in dic[@"tabs"]) {
            QHQTabBarItem *item = [[QHQTabBarItem alloc] initWithDic:tabDic];
            item.resourceName = _resourceName;
            [tabBarItems addObject:item];
        }
        _tabItems = [tabBarItems copy];
        
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self)
    {
        self.resourceUrl = [aDecoder decodeObjectForKey:@"resourceUrl"];
        self.md5 = [aDecoder decodeObjectForKey:@"md5"] ;
        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
        self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
        self.resourceName = [aDecoder decodeObjectForKey:@"resourceName"];
        self.tabItems = [aDecoder decodeObjectForKey:@"tab"];
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.resourceUrl forKey:@"resourceUrl"];
    [aCoder encodeObject:self.md5 forKey:@"md5"];
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.endDate forKey:@"endDate"];
    [aCoder encodeObject:self.tabItems forKey:@"tab"];
    [aCoder encodeObject:self.resourceName forKey:@"resourceName"];
}

- (BOOL)checkDateForShow {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter dateFromString:_startDate];
    NSDate *endDate = [formatter dateFromString:_endDate];
    NSDate *date = [NSDate date];
    return date.timeIntervalSince1970 >= startDate.timeIntervalSince1970 && date.timeIntervalSince1970 < endDate.timeIntervalSince1970;
}

@end
