//
//  QHQPlayView.m
//
//  Created by lujianwen on 2018/11/29.
//  Copyright © 2018  All rights reserved.
//

#import "QHQPlayerView.h"

@interface QHQPlayerView ()

@property (nonatomic, strong, readwrite) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playItem;

@property (nonatomic, strong) UIImageView *placeholderView;

@end

@implementation QHQPlayerView

- (void)dealloc {
    [_playItem removeObserver:self forKeyPath:@"status"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _placeholderView = [[UIImageView alloc] init];
        [self addSubview:_placeholderView];
    }
    return self;
}

- (void)setPath:(NSString *)path {
    [self setPath:path placeholder:YES];
}

- (void)setPath:(NSString *)path placeholder:(BOOL)placeholder {
    _path = path;
    NSURL *url;
    if (_type == kQHQPlayerViewResourceTypeNative) {
        url = [NSURL fileURLWithPath:path];
    } else {
        url = [NSURL URLWithString:path];
    }
    
    if (placeholder) {
        _placeholderView.image = [QHQPlayerView getVideoPreViewImage:url];
    }
    
    _playItem = [AVPlayerItem playerItemWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:_playItem];
    [_playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _playerLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_playerLayer];
}

- (void)play {
    [_playItem seekToTime:kCMTimeZero];
    [_player play];
}

- (void)pause {
    [_player pause];
    [_playItem seekToTime:kCMTimeZero];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _playerLayer.frame = self.bounds;
    _placeholderView.frame = self.bounds;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]){
        if (playerItem.status == AVPlayerItemStatusReadyToPlay){
            NSLog(@"playerItem is ready");
            _placeholderView.hidden = YES;
        } else{
            NSLog(@"load break");
        }
    }
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
