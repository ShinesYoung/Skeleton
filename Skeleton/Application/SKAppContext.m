//
//  SKAppContext.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKAppContext.h"

@implementation SKAppContext

/******************************************************************************/
/**** Singlton Method                                                      ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singlton Method

+ (SKAppContext *)sharedContext
{
    static SKAppContext *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SKAppContext new];
    });
    return instance;
}

@end
