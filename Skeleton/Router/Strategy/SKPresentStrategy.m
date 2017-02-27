//
//  SKPresentStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKPresentStrategy.h"

@implementation SKPresentStrategy

/******************************************************************************/
/**** Strategy Loading method                                              ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerStrategy:[SKPresentStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vStgyNamePresent;
}

+ (BOOL)routingData:(id)data params:(NSDictionary *)params
{
    UIViewController *rootVC
    = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([data isKindOfClass:[UIViewController class]])
    {
        [rootVC presentViewController:data animated:YES completion:nil];
        return YES;
    }
    return NO;
}

@end
