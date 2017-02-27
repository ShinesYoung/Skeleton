//
//  SKStackTopStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKStackTopStrategy.h"

@implementation SKStackTopStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKStackTopStrategy new]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


- (NSString *)strategyName
{
    return vRouteStgyNameStackTop;
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
        [(UINavigationController *)rootVC pushViewController:result animated:YES];
    }
    return result;
}

@end
