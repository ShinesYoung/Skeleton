//
//  SKWindow.m
//  Skeleton
//
//  Created by yangshansi on 2017/8/1.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKWindow.h"

@implementation SKWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    
    // 可以采用异步线程处理
    if (event.type == UIEventTypeTouches)
    {
        UIViewController *topVC = [self currentTopVC:self.rootViewController];
        NSLog(@"sendEvent, %@, %ld, %ld, %@", [topVC class], event.type, event.subtype, event.allTouches);
        
    }
    
    
}

- (UIViewController *)currentTopVC:(UIViewController *)parentVC
{
    UIViewController *topVC = parentVC;
    if ([parentVC presentedViewController] != nil &&
        [[parentVC presentedViewController] isKindOfClass:[UIAlertController class]] == NO)
    {
        topVC = [parentVC parentViewController];
        [self currentTopVC:topVC];
    }
    else if ([parentVC isKindOfClass:[UINavigationController class]]) {
        topVC = [parentVC.childViewControllers lastObject];
        return [self currentTopVC:topVC];
    }
    else if ([parentVC isKindOfClass:[UITabBarController class]]) {
        topVC = [(UITabBarController *)parentVC selectedViewController];
        return [self currentTopVC:topVC];
    }
    else {
        if (topVC.childViewControllers.count > 0)
        {
            topVC = [parentVC.childViewControllers lastObject];
            return [self currentTopVC:topVC];
        }
    }
    return topVC;
}


@end
