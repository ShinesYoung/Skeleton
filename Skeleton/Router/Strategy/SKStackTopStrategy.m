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
    [[SKRouter sharedRouter] registerStrategy:[SKStackTopStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vStgyNameStackTop;
}

+ (BOOL)routingData:(id)data params:(NSDictionary *)params
{
    UIViewController *rootVC
    = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([data   isKindOfClass:[UIViewController class]] &&
        [rootVC isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)rootVC pushViewController:data animated:YES];
        return YES;
    }
    return NO;
}

@end
