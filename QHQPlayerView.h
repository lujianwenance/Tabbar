//
//  QHQPlayView.h
//
//  Created by lujianwen on 2018/11/29.
//  Copyright © 2018  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, kQHQPlayerViewResourceType) {
    kQHQPlayerViewResourceTypeNative,
    kQHQPlayerViewResourceTypeDownload
};

@interface QHQPlayerView : UIView

@property (nonatomic, strong, readonly) AVPlayer *player;
@property (nonatomic, strong) NSString *path; //default is using placeholder
@property (nonatomic, assign) kQHQPlayerViewResourceType type; //set type before setting url ,default is native

@property (nonatomic, assign) BOOL shouldPlay;

- (void)setPath:(NSString *)path placeholder:(BOOL)placeholder;
- (void)play;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
