//
//  SKRootStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKRootStrategy.h"

@implementation SKRootStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKRootStrategy new]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


- (NSString *)strategyName
{
    return vRouteStgyNameRoot;
}

- (id)routing:(SKModule *)aModule action:(SEL)aSelector params:(NSDictionary *)params
{
    //id result = [aModule performSelector:aSelector withObject:params];
    IMP imp = [aModule methodForSelector:aSelector];
    id (*func)(id, SEL) = (void *)imp;
    id result = func(aModule, aSelector);
    [self injectParams:params inObject:result];
    
    if ([result isKindOfClass:[UIViewController class]])
    {
        [UIApplication sharedApplication].keyWindow.rootViewController = result;
    }
    return result;
}


@end
