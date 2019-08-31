//
//  QHQUtility.h
//
//  Created by lujianwen on 2018/10/30.
//  Copyright © 2018  All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QHQUtility : NSObject

+ (NSOperationQueue *)shareOperationQueue;
+ (void)addOperation:(NSOperation *)operation;
+ (void)addOperation:(NSOperation *)operation priority:(NSOperationQueuePriority)priority;

+ (NSString *)md5WithLowerString:(NSString *)str;
+ (NSString *)md5WithUpperString:(NSString *)str;
+ (NSString *)md5WithPath:(NSString *)path;

/**
 获取加载webView的公共信息
 */
+ (NSMutableDictionary *)getWebViewInfo;

/**
 根据是否今年截取时间
 今年：月-日
 非今年：年-月-日
 */
+ (NSString *)setTimeForYear:(NSString *)time;

+ (UIImage*)getVideoPreViewImage:(NSURL *)path;

@end

NS_ASSUME_NONNULL_END
