//
//  QHQUtility.m
//
//  Created by lujianwen on 2018/10/30.
//  Copyright © 2018  All rights reserved.
//

#import "QHQUtility.h"
#import "NSDateFormatter+JDBase.h"
#import "NSDate+JDBase.h"
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVTime.h>
#import <AVFoundation/AVAssetImageGenerator.h>

@implementation QHQUtility

+ (NSOperationQueue *)shareOperationQueue {
    static NSOperationQueue *_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 10;
    });
    return _queue;
}

+ (void)addOperation:(NSOperation *)operation {
    [[QHQUtility shareOperationQueue] addOperation:operation];
}

+ (void)addOperation:(NSOperation *)operation priority:(NSOperationQueuePriority)priority {
    operation.queuePriority = priority;
    [[QHQUtility shareOperationQueue] addOperation:operation];
}

+ (NSString *)md5WithLowerString:(NSString *)str {
    return [[QHQUtility md5WithString:str] lowercaseString];
}

+ (NSString *)md5WithUpperString:(NSString *)str {
    return [[QHQUtility md5WithString:str] uppercaseString];
}

+ (NSString *)md5WithString:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}

+ (NSString *)md5WithPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path isDirectory:nil]){
        NSData *data = [NSData dataWithContentsOfFile:path];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5(data.bytes,(CC_LONG)data.length,digest);
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0;i < CC_MD5_DIGEST_LENGTH;i++ ){
            [output appendFormat:@"%02x", digest[i]];
        }
        
        return output;
    }
    return nil;
}

+ (NSString *)setTimeForYear:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [[NSTimeZone alloc] initWithName:@"UTC"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *timeDate = [formatter dateFromString:time];
    if ([timeDate isThisYear]) {
        [formatter setDateFormat:@"MM/dd"];
    } else {
        [formatter setDateFormat:@"yyyy/MM/dd"];
    }
    NSString *newTime = [formatter stringFromDate:timeDate];
    return newTime;
}


+ (UIImage*)getVideoPreViewImage:(NSURL *)path {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
@end
