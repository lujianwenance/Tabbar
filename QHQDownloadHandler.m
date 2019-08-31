//
//  QHQDownloadHandler.m
//
//  Created by lujianwen on 2018/12/3.
//  Copyright © 2018 All rights reserved.
//

#import "QHQDownloadHandler.h"
#import "JDDefaultHttpClient.h"
#import "QHQResourceManager.h"
#import "QHQUtility.h"
#import <AFNetworking.h>
#import "JDDataHandler.h"
#import "NSString+Category.h"

#define TabBarResourceCachedList [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"tabBarResourceCachedList.data"]
#define SplashResourceCachedList [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"splashResourceCachedList.data"]

@implementation QHQDownloadHandler

+ (void)downloadResourceWithUrl:(NSString *)url md5:(NSString *)md5 destination:(nonnull NSString *)destination completion:(void (^)(void))completion {
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:destination];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"下载失败:%@",error);
        } else {
            if (md5.length) {
                //校验md5
                if ([md5 isEqualToString:[QHQUtility md5WithPath:destination]]) {
                    if (completion) {
                        completion();
                    }
                } else {
                    [QHQResourceManager removeFileWithFilePath:destination];
                }
            } else {
                if (completion) {
                    completion();
                }
            }
        }
    }];
    [download resume];
}

+ (void)downloadTabBarResourceWithUrl:(NSString *)url md5:(NSString *)md5 completion:(void (^)(BOOL))completion {
    NSDictionary *cachedList = [JDDataHandler syncUnarchiveObjectAtPath:TabBarResourceCachedList];
    if (cachedList && cachedList.count) {
        if (cachedList[url.jdfq_MD5]) {
            if (completion) {
                completion(YES);
            }
            return;
        }
    }
    NSString *destination = [DocumentDirectoryPath stringByAppendingPathComponent:TabBarResourcePath];
    NSString *fileName = [url lastPathComponent];
    NSString *filePath = [destination stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destination]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [QHQDownloadHandler downloadResourceWithUrl:url md5:md5 destination:filePath completion:^{
        NSMutableDictionary *cachedList = [[JDDataHandler syncUnarchiveObjectAtPath:TabBarResourceCachedList] mutableCopy];
        if (cachedList) {
            [cachedList setObject:@(YES) forKey:url.jdfq_MD5];
        } else {
            cachedList = [NSMutableDictionary dictionary];
            [cachedList setObject:@(YES) forKey:url.jdfq_MD5];
        }
        [JDDataHandler asyncArchiveObject:cachedList toPath:TabBarResourceCachedList completion:^(BOOL success) {
            if (completion) {
                completion(NO);
            }
        }];
        
        [[QHQResourceManager defaultManager] unpressFileWithPath:filePath];
    }];
}

+ (void)downloadSplashResourceWithUrl:(NSString *)url md5:(NSString *)md5 completion:(void (^)(BOOL))completion {
    NSDictionary *cachedList = [JDDataHandler syncUnarchiveObjectAtPath:SplashResourceCachedList];
    if (cachedList && cachedList.count) {
        if (cachedList[url.jdfq_MD5] && completion) {
            completion(YES);
        }
    }
    NSString *destination = [DocumentDirectoryPath stringByAppendingPathComponent:SplashResourcePath];
    NSString *fileName = [url lastPathComponent];
    NSString *filePath = [destination stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destination]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [QHQDownloadHandler downloadResourceWithUrl:url md5:md5 destination:filePath completion:^{
        NSMutableDictionary *cachedList = [[JDDataHandler syncUnarchiveObjectAtPath:SplashResourceCachedList] mutableCopy];
        if (cachedList) {
            [cachedList setObject:@(YES) forKey:url.jdfq_MD5];
        } else {
            cachedList = [NSMutableDictionary dictionary];
            [cachedList setObject:@(YES) forKey:url.jdfq_MD5];
        }
        [JDDataHandler asyncArchiveObject:cachedList toPath:SplashResourceCachedList completion:^(BOOL success) {
            if (completion) {
                completion(NO);
            }
        }];
        [[QHQResourceManager defaultManager] unpressFileWithPath:filePath];
    }];
}

@end
