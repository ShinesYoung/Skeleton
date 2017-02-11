//
//  SKAppContext.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKAppContext : NSObject

/******************************************************************************/
/**** Singlton Method                                                      ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singlton Method

+ (SKAppContext *)sharedContext;

@end
