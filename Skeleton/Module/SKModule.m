//
//  SKModule.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKModule.h"

@implementation SKModule

- (NSInteger)moduleLevel
{
    return fft_module_level_default;
}

- (NSString *)moduleName
{
    return NSStringFromClass([self class]);
}

@end
