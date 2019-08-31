//
//  QHQResourceManager.h
//
//  Created by lujianwen on 2018/12/3.
//  Copyright © 2018 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSZipArchive.h"

#define DocumentDirectoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define TabBarResourcePath @"TabBar"
#define SplashResourcePath @"Splash"

NS_ASSUME_NONNULL_BEGIN

@interface QHQResourceManager : NSObject <SSZipArchiveDelegate>

+ (instancetype)defaultManager;

- (void)unpressFileWithPath:(NSString *)filePath;
//获取资源 (备注：fileName需要加上后缀)
+ (NSData *)fetchResourceWithFilePath:(NSString *)filePath;
+ (NSData *)fetchTabBarResourceWithFileName:(NSString *)fileName inFolder:(NSString *)folder;
+ (NSData *)fetchSplashResourceWithFileName:(NSString *)fileName inFolder:(NSString *)folder;
//获取资源路径(备注：fileName需要加上后缀)
+ (NSString *)getTabBarResourcePathWithFileName:(NSString *)fileName inFolder:(NSString *)folder;
+ (NSString *)getSplashResourcePathWithFileName:(NSString *)fileName inFolder:(NSString *)folder;

+ (BOOL)isExistsOfTabBarResourceWithName:(NSString *)name;

+ (void)removeFileWithFilePath:(NSString *)filePath;

+ (void)removeFilesWithPath:(NSString *)path ignoreFileNames:(NSArray *)fileNames;

@end

NS_ASSUME_NONNULL_END
