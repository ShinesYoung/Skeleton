//
//  SKStackResetStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/3/8.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKStackResetStrategy.h"

@implementation SKStackResetStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKStackResetStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vRouteStgyStackReset;
}

+ (id)routing:(id)data params:(NSDictionary *)params
{
    UIViewController *rootVC
    = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([rootVC isKindOfClass:[UINavigationController class]] &&
        [data isKindOfClass:[NSArray class]] && data != nil &&
        [(NSArray *)data count] > 0)
    {
        UINavigationController *rootNC = (UINavigationController *)rootVC;
        rootNC.viewControllers = data;
    }
    return data;
}

@end
