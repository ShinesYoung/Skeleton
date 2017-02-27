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
    [[SKRouter sharedRouter] registerStrategy:[SKRootStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vStgyNameRoot;
}

+ (BOOL)routingData:(id)data params:(NSDictionary *)params
{
    if ([data isKindOfClass:[UIViewController class]])
    {
        [UIApplication sharedApplication].keyWindow.rootViewController = data;
        return YES;
    }
    return NO;
}


@end
