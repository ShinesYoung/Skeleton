//
//  SKStackPushAboveStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKStackPushAboveStrategy.h"

@implementation SKStackPushAboveStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKStackPushAboveStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vStgyNameStackPushAbove;
}

+ (BOOL)routingData:(id)data params:(NSDictionary *)params
{
    UIViewController *rootVC
    = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([data   isKindOfClass:[UIViewController class]] &&
        [rootVC isKindOfClass:[UINavigationController class]])
    {
        UIViewController *popToVC = [params valueForKey:kPopToVC];
        
        UINavigationController *rootNC = (UINavigationController *)rootVC;
        
        [rootNC popToViewController:popToVC animated:NO];
        [rootNC pushViewController:data animated:YES];
        return YES;
    }
    return NO;
}


@end
