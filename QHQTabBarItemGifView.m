//
//  QHQTabBarItemGifView.m
//
//  Created by lujianwen on 2018/11/26.
//  Copyright © 2018 All rights reserved.
//

#import "QHQTabBarItemGifView.h"
#import <FLAnimatedImageView+WebCache.h>
#import "QHQResourceManager.h"

@interface QHQTabBarItemGifView ()

@property (nonatomic, strong) FLAnimatedImageView *imageView;

@end

@implementation QHQTabBarItemGifView

- (void)setupUI {
    [super setupUI];
    
    _imageView = [[FLAnimatedImageView alloc] init];
    [self.contentView addSubview:_imageView];
}

- (void)setContent:(id)content {
    [self setupImageViewWith:(NSData *)content];
}

- (void)setIsSelected:(BOOL)isSelected {
    [super setIsSelected:isSelected];
    if (isSelected) {
        [_imageView startAnimating];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
}

- (void)setupImageViewWith:(NSData *)imageData {
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)imageData, nil);
    NSInteger frameCount = CGImageSourceGetCount(imageSource);
    float duration =0;
    NSMutableArray *images = [NSMutableArray array];
    for(int i =0; i < frameCount; i ++) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
        CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil);
        NSDictionary *gifInfo = (__bridge NSDictionary*)properties;
        duration = [gifInfo[@"{GIF}"][@"DelayTime"] doubleValue] + duration;
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        [images addObject:image];
        if (i == frameCount - 1) {
            _imageView.image = image;
        }
    }
    _imageView.animationImages = images;
    _imageView.animationDuration = duration;
    _imageView.animationRepeatCount = 1;
}

@end
