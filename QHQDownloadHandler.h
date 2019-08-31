//
//  QHQDownloadHandler.h
//
//  Created by lujianwen on 2018/12/3.
//  Copyright © 2018 All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QHQDownloadHandler : NSObject
//md5可以为空  为空表示不校验md5
+ (void)downloadResourceWithUrl:(NSString *)url md5:(nullable NSString *)md5 destination:(NSString *)destination completion:(void(^__nullable)(void))completion;

+ (void)downloadSplashResourceWithUrl:(NSString *)url md5:(nullable NSString *)md5 completion:(void(^__nullable)(BOOL isCached))completion;
+ (void)downloadTabBarResourceWithUrl:(NSString *)url md5:(nullable NSString *)md5 completion:(void(^__nullable)(BOOL isCached))completion;

@end

NS_ASSUME_NONNULL_END
