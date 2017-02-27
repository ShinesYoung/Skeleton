//
//  SKStackAboveBottomStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKStackAboveBottomStrategy.h"

@implementation SKStackAboveBottomStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKStackAboveBottomStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vStgyNameStackAboveBottom;
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
        [rootNC pushViewController:data animated:YES];
        
        return YES;
    }
    return NO;
}

@end
