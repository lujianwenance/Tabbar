//
//  QHQResourceManager.m
//
//  Created by lujianwen on 2018/12/3.
//  Copyright © 2018 All rights reserved.
//

#import "QHQResourceManager.h"
#import "QHQUtility.h"

@implementation QHQResourceManager

+ (instancetype)defaultManager {
    static QHQResourceManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[QHQResourceManager alloc] init];
    });
    return _manager;
}

- (void)unpressFileWithPath:(NSString *)filePath {
    NSString *fileDir = filePath.stringByDeletingPathExtension;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        NSBlockOperation *unzipOperation = [NSBlockOperation blockOperationWithBlock:^{
            [SSZipArchive unzipFileAtPath:filePath toDestination:fileDir delegate:self];
        }];
        [[QHQUtility shareOperationQueue] addOperation:unzipOperation];
    } else {
        NSLog(@"The filePath error... file is not exist...");
    }
}

+ (NSData *)fetchResourceWithFilePath:(NSString *)filePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filePath]) {
        return nil;
    }
    return [fm contentsAtPath:filePath];
}

+ (NSData *)fetchTabBarResourceWithFileName:(NSString *)fileName inFolder:(NSString *)folder{
    return [QHQResourceManager fetchResourceWithFilePath:[QHQResourceManager getTabBarResourcePathWithFileName:fileName inFolder:folder]];
}

+ (NSData *)fetchSplashResourceWithFileName:(NSString *)fileName inFolder:(NSString *)folder{
    return [QHQResourceManager fetchResourceWithFilePath:[QHQResourceManager getSplashResourcePathWithFileName:fileName inFolder:folder]];
}

+ (NSString *)getTabBarResourcePathWithFileName:(NSString *)fileName inFolder:(NSString *)folder{
    NSString *fileDir = [DocumentDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",TabBarResourcePath,folder]];
    return [fileDir stringByAppendingPathComponent:fileName];
}

+ (NSString *)getSplashResourcePathWithFileName:(NSString *)fileName inFolder:(NSString *)folder{
    NSString *fileDir = [DocumentDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",SplashResourcePath,folder]];
    return [fileDir stringByAppendingPathComponent:fileName];
}

+ (BOOL)isExistsOfTabBarResourceWithName:(NSString *)name {
    NSString *fileDir = [DocumentDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",TabBarResourcePath,name]];
    return [[NSFileManager defaultManager] fileExistsAtPath:fileDir];
}

+ (void)removeFileWithFilePath:(NSString *)filePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:filePath error:nil];
}

+ (void)removeFilesWithPath:(NSString *)path ignoreFileNames:(NSArray *)fileNames {
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            NSArray *dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            for (NSString *fileName in dirArray) {
                if (![fileNames containsObject:fileName]) {
                    
                }
            }
        }else{
            NSLog(@"this path is not directory...");
        }
    }else{
        NSLog(@"this path is not exist...");
    }
}

#pragma mark - SSZipArchiveDelegate

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath {
    NSString *key = [path lastPathComponent];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [QHQResourceManager removeFileWithFilePath:path];
}

@end
