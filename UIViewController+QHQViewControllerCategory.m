//
//  UIViewController+QHQViewControllerCategory.m
//
//  Created by lujianwen on 2018/11/19.
//  Copyright © 2018  All rights reserved.
//

#import "UIViewController+QHQViewControllerCategory.h"

@implementation UIViewController (QHQViewControllerCategory)

- (UIViewController *)qhq_getViewControllerInsteadOfNavigationController {
    BOOL isNavigationController = [[self class] isSubclassOfClass:[UINavigationController class]];
    if (isNavigationController && ((UINavigationController *)self).viewControllers.count > 0) {
        return ((UINavigationController *)self).viewControllers[0];
    }
    return self;
}

@end
