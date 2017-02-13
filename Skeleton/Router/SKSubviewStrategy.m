//
//  SKSubviewStrategy.m
//  Skeleton
//
//  Created by Shines Young on 2017/2/13.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKSubviewStrategy.h"

@implementation SKSubviewStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKSubviewStrategy new]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


- (NSString *)strategyName
{
    return vRouteStgyNameSubview;
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
        [rootVC isKindOfClass:[UIViewController class]])
    {
        UIViewController *subVC = (UIViewController *)result;
        
        [rootVC.view addSubview:subVC.view];
        [rootVC addChildViewController:subVC];
    }
    return result;
}

@end
