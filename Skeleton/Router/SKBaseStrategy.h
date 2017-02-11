//
//  SKBaseStrategy.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKRouter.h"

@interface SKBaseStrategy : NSObject <SKRoutingStrategy>

- (void)injectParams:(NSDictionary *)params inObject:(NSObject *)aObj;

@end
