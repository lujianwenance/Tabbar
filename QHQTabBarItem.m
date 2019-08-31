//
//  QHQTabBarItem.m
//
//  Created by lujianwen on 2018/11/19.
//  Copyright © 2018 All rights reserved.
//

#import "QHQTabBarItem.h"

NSString *const kTabBarControllerForLoan        = @"loan";
NSString *const kTabBarControllerForMall        = @"mall";
NSString *const kTabBarControllerForRepay       = @"repay";
NSString *const kTabBarControllerForDiscover    = @"discover";
NSString *const kTabBarControllerForMine        = @"mine";

static NSString *TabBarItemViewTypePng          = @"png";
static NSString *TabBarItemViewTypeJson         = @"json";
static NSString *TabBarItemViewTypeGif          = @"gif";
static NSString *TabBarItemViewTypeMp4          = @"mp4";

@implementation QHQTabBarItem {
    CGFloat _iconWidth;
    CGFloat _iconHeight;
}

- (instancetype)initWithDic:(NSDictionary *)aDic {
    self = [super init];
    if (self) {
        _title = aDic[@"name"];
        _code = aDic[@"code"];
        _show = [aDic[@"show"] boolValue];
        _index = [aDic[@"index"] integerValue];
        _normalStyle = [aDic[@"normalStyle"] intValue];
        _selectedStyle = [aDic[@"selectedStyle"] intValue];
        _normalIcon = aDic[@"normalIcon"];
        _selectedIcon = aDic[@"selectedIcon"];
        _normalType = [self parseTabBarItemType:aDic[@"normalIcon"]];
        _selectedType = [self parseTabBarItemType:aDic[@"selectedIcon"]];
        _normalIconSize = [self initIconSizeWithString:aDic[@"normalIconSize"]];
        _selectedIconSize = [self initIconSizeWithString:aDic[@"selectedIconSize"]];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    QHQTabBarItem *item = [[QHQTabBarItem alloc] init];
    item.title = self.title;
    item.normalType = self.normalType;
    item.selectedType = self.selectedType;
    item.normalStyle = self.normalStyle;
    item.selectedStyle = self.selectedStyle;
    item.show = self.show;
    item.index = self.index;
    item.normalIcon = self.normalIcon;
    item.selectedIcon = self.selectedIcon;
    item.normalIconSize = self.normalIconSize;
    item.selectedIconSize = self.selectedIconSize;
    return item;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self)
    {
        self.title = [aDecoder decodeObjectForKey:@"name"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.normalType = [aDecoder decodeIntForKey:@"normalType"] ;
        self.selectedType = [aDecoder decodeIntForKey:@"selectedType"];
        self.normalStyle = [aDecoder decodeIntForKey:@"normalStyle"];
        self.selectedStyle = [aDecoder decodeIntForKey:@"selectedStyle"];
        self.show = [aDecoder decodeBoolForKey:@"show"];
        self.index = [aDecoder decodeIntForKey:@"index"] ;
        self.normalIcon = [aDecoder decodeObjectForKey:@"normalIcon"];
        self.selectedIcon = [aDecoder decodeObjectForKey:@"selectedIcon"];
        self.normalIconSize = ((NSValue *)[aDecoder decodeObjectForKey:@"normalIconSize"]).CGSizeValue;
        self.selectedIconSize = ((NSValue *)[aDecoder decodeObjectForKey:@"selectedIconSize"]).CGSizeValue;
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"name"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeInteger:self.normalType forKey:@"normalType"];
    [aCoder encodeInteger:self.selectedType forKey:@"selectedType"];
    [aCoder encodeInteger:self.normalStyle forKey:@"normalStyle"];
    [aCoder encodeInteger:self.selectedStyle forKey:@"selectedStyle"];
    [aCoder encodeInteger:self.index forKey:@"index"];
    [aCoder encodeBool:self.show forKey:@"show"];
    [aCoder encodeObject:self.normalIcon forKey:@"normalIcon"];
    [aCoder encodeObject:self.selectedIcon forKey:@"selectedIcon"];
    [aCoder encodeObject:[NSValue valueWithCGSize:self.normalIconSize] forKey:@"normalIconSize"];
    [aCoder encodeObject:[NSValue valueWithCGSize:self.selectedIconSize] forKey:@"selectedIconSize"];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"%p title:%@  show:%d  code:%@ _normalType:%ld  _normalStyle:%ld index:%ld icon:%@  selecedIcon:%@",self,_title,_show,_code,(long)_normalType,(long)_normalStyle,(long)_index,_normalIcon,_selectedIcon];
}

- (kQHQTabBarItemViewType)parseTabBarItemType:(NSString *)type {
    kQHQTabBarItemViewType tabBarItemType;
    if ([type containsString:@"{"]) {
        return kQHQTabBarItemViewTypeJson;
    }
    NSString *typeString = [[type componentsSeparatedByString:@"."] lastObject];
    if ([typeString isEqualToString:TabBarItemViewTypePng]) {
        tabBarItemType = kQHQTabBarItemViewTypeDefault;
    } else if ([typeString isEqualToString:TabBarItemViewTypeGif]) {
        tabBarItemType = kQHQTabBarItemViewTypeGif;
    } else if ([typeString isEqualToString:TabBarItemViewTypeMp4]) {
        tabBarItemType = kQHQTabBarItemViewTypeMovie;
    } else {
        tabBarItemType = kQHQTabBarItemViewTypeDefault;
    }
    return tabBarItemType;
}

- (CGSize)initIconSizeWithString:(NSString *)string {
//    NSArray *components = [string componentsSeparatedByString:@"*"];
//    if (components.count != 2) {
//        return CGSizeMake(24, 24);
//    }
//    return CGSizeMake([components[0] floatValue], [components[1] floatValue]);
    CGFloat width = [self getWidth:string];
    return CGSizeMake(width, width);
}

- (CGFloat)getWidth:(NSString *)string {
    return string.floatValue / 2;
}

@end
