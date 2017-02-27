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
    [[SKRouter sharedRouter] registerStrategy:[SKSubviewStrategy class]];
}

/******************************************************************************/
/**** Strategy Protocol method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy Protocol method


+ (NSString *)strategyName
{
    return vStgyNameSubview;
}

+ (BOOL)routingData:(id)data params:(NSDictionary *)params
{
    UIViewController *rootVC
    = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([data isKindOfClass:[UIViewController class]])
    {
        UIViewController *subVC = (UIViewController *)data;
        
        [rootVC.view addSubview:subVC.view];
        [rootVC addChildViewController:subVC];
        return YES;
    }
    return NO;
}

@end
