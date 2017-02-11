//
//  SKBaseStrategy.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKBaseStrategy.h"

@implementation SKBaseStrategy

- (NSString *)strategyName
{
    return NSStringFromClass(self.class);
}

- (id)routing:(SKModule *)aModule action:(SEL)aSelector params:(NSDictionary *)params
{
    // do nothing
    return nil;
}

- (void)injectParams:(NSDictionary *)params inObject:(NSObject *)aObj
{
    if ([aObj isKindOfClass:[NSObject class]] == NO)
    {
        return;
    }
    
    for (NSString *aKey in params.allKeys)
    {
        NSString *aValue = [params valueForKey:aKey];
        NSLog(@"aK=%@ aV=%@",aKey, aValue);
        SEL aSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
                                              [[aKey substringToIndex:1] uppercaseString],
                                              [aKey substringFromIndex:1]]);
        if ([aObj respondsToSelector:aSelector])
        {
            [aObj setValue:aValue forKeyPath:aKey];
        }
        
    }
}

@end
