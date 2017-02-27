//
//  SKStackBottomStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKStackBottomStrategy.h"

@implementation SKStackBottomStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKStackBottomStrategy new]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


- (NSString *)strategyName
{
    return vRouteStgyNameStackBottom;
}

- (id)routing:(SKModule *)aModule action:(SEL)aSelector params:(NSDictionary *)params
{
    //id result = [aModule performSelector:aSelector withObject:params];
    IMP imp = [aModule methodForSelector:aSelector];
    id (*func)(id, SEL) = (void *)imp;
    id result = func(aModule, aSelector);
    
    [self injectParams:params inObject:result];
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([result isKindOfClass:[UIViewController class]] &&
        [rootVC isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *rootNC = (UINavigationController *)rootVC;
        
        [rootNC popToRootViewControllerAnimated:NO];
        rootNC.viewControllers = @[result];
    }
    return result;
}

@end
