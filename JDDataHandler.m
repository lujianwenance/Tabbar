//
//  CLDataHandler.m
//  ColorfulLife
//
//  Created by lujianwen on 2018/8/21.
//  Copyright © 2018年 jindan. All rights reserved.
//

#import "JDDataHandler.h"
#import "QHQUtility.h"

@implementation JDDataHandler

+ (BOOL)syncArchiveObject:(id)obj toPath:(NSString *)path {
    id beArchivedObject = nil;
    
    if ([obj respondsToSelector:@selector(copyWithZone:)]) {
        beArchivedObject = [obj copy];
    } else {
        beArchivedObject = obj;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:beArchivedObject];
    NSError *error = nil;
    [data writeToFile:path options:NSDataWritingAtomic error:&error];
    
    if (error) {
        NSLog(@"archived %@ to file %@, error: %@", [obj class], path, error);
        return NO;
    }
    
    return YES;
}

+ (void)asyncArchiveObject:(id)obj toPath:(NSString *)path completion:(void (^)(BOOL))completion {
    if (obj == nil || path.length == 0) {
        return;
    }
    NSBlockOperation *archiveOperation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL succeed = [JDDataHandler syncArchiveObject:obj toPath:path];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(succeed);
            });
        }
    }];
    [QHQUtility addOperation:archiveOperation priority:NSOperationQueuePriorityLow];
}

+ (void)asyncArchiveObject:(id)obj toPath:(NSString *)path {
    [JDDataHandler asyncArchiveObject:obj toPath:path completion:nil];
}

+ (id)syncUnarchiveObjectAtPath:(NSString *)path {
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        return nil;
    }
    
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return object;
}

+ (void)asyncUnarchiveObjectAtPath:(NSString *)path withCompletion:(void (^)(id))completion {
    NSBlockOperation *unArchiveOperation = [NSBlockOperation blockOperationWithBlock:^{
        id object = [JDDataHandler syncUnarchiveObjectAtPath:path];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(object);
            });
        }
    }];
    [QHQUtility addOperation:unArchiveOperation priority:NSOperationQueuePriorityLow];
}

+ (BOOL)removeItemAtPath:(NSString *)path {
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (!success || error) {
        NSLog(@"Remove item error: %@", error?:@"");
        return NO;
    }
    return YES;
}

@end
