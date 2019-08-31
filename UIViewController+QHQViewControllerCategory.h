//
//  UIViewController+QHQViewControllerCategory.h
//
//  Created by lujianwen on 2018/11/19.
//  Copyright © 2018  All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (QHQViewControllerCategory)

- (UIViewController *)qhq_getViewControllerInsteadOfNavigationController;

@end

NS_ASSUME_NONNULL_END
