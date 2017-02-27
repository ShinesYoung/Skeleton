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
    [[SKRouter sharedRouter] registerStrategy:[SKStackBottomStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vStgyNameStackBottom;
}

+ (BOOL)routingData:(id)data params:(NSDictionary *)params
{
    UIViewController *rootVC
    = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([data   isKindOfClass:[UIViewController class]] &&
        [rootVC isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *rootNC = (UINavigationController *)rootVC;
        
        [rootNC popToRootViewControllerAnimated:NO];
        rootNC.viewControllers = @[data];
        return YES;
    }
    return NO;
}

@end
