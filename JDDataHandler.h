//
//  CLDataHandler.h
//  ColorfulLife
//
//  Created by lujianwen on 2018/8/21.
//  Copyright © 2018年 jindan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDDataHandler : NSObject

+ (BOOL)syncArchiveObject:(id)obj toPath:(NSString *)path;
+ (void)asyncArchiveObject:(id)obj toPath:(NSString *)path;
+ (void)asyncArchiveObject:(id)obj toPath:(NSString *)path completion:(void (^)(BOOL success))completion;

+ (id)syncUnarchiveObjectAtPath:(NSString *)path;
+ (void)asyncUnarchiveObjectAtPath:(NSString *)path withCompletion:(void (^)(id object))completion;

+ (BOOL)removeItemAtPath:(NSString *)path;

@end
