//
//  SKDataStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKDataStrategy.h"

@implementation SKDataStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKDataStrategy new]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


- (NSString *)strategyName
{
    return vRouteStgyNameData;
}

- (id)routing:(SKModule *)aModule action:(SEL)aSelector params:(NSDictionary *)params
{
    IMP imp = [aModule methodForSelector:aSelector];
    id (*func)(id, SEL) = (void *)imp;
    id result = func(aModule, aSelector);
    
    [self injectParams:params inObject:result];
    return result;
}

@end
