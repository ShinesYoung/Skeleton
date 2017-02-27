//
//  SKBaseStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKBaseStrategy.h"

@implementation SKBaseStrategy

+ (NSString *)strategyName
{
    return NSStringFromClass(self.class);
}

+ (BOOL)routingData:(id)data params:(NSDictionary *)params
{
    return YES;
}



@end
