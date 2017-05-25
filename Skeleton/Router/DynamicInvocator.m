//
//  DynamicInvocator.m
//  Skeleton
//
//  Created by yangshansi on 2017/5/24.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "DynamicInvocator.h"

@implementation DynamicInvocator

- (id)inovkeClassName:(NSString *)className methodName:(NSString *)methodName
{
    return nil;
}


- (id)invokeClass:(Class)aClass method:(Method)aMethod
{
    return nil;
}


- (id)invokeInstance:(id)aOjbect selector:(SEL)aSelector
{
    return [self invokeInstance:aOjbect selector:aSelector params:nil];
}

- (id)invokeInstance:(id)aOjbect selector:(SEL)aSelector params:(NSDictionary *)params
{
    NSLog(@"invokeInstance:selector: get params %@", params);
    
    // get class & selector
    Class aClass = [aOjbect class];
    
    // get Method
    Method aMethod = class_getInstanceMethod(aClass, aSelector);
    
    // get returnType
    char* retType = method_copyReturnType(aMethod);
    
    IMP imp = [aOjbect methodForSelector:aSelector];
    if      (strcmp("v", retType) == 0)  // return void
    {
        void (*func)(id, SEL, ...) = (void *)imp;
        func(aOjbect, aSelector, params);
    }
    else if (strcmp("@", retType) == 0)  // return id
    {
        id   (*func)(id, SEL, ...) = (void *)imp;
        id data = func(aOjbect, aSelector, params);
        return data;
    }
    else if (strcmp("B", retType) == 0)   // return BOOL
    {
        BOOL (*func)(id, SEL, ...) = (void *)imp;
        BOOL boolResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithBool:boolResult];
    }
    else if (strcmp("i", retType) == 0)   // return int
    {
        int  (*func)(id, SEL, ...) = (void *)imp;
        int intResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithInt:intResult];
    }
    else if (strcmp("I", retType) == 0)   // return unsigned int
    {
        unsigned int  (*func)(id, SEL, ...) = (void *)imp;
        unsigned int intResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithUnsignedInt:intResult];
    }
    else if (strcmp("q", retType) == 0)   // return long
    {
        long (*func)(id, SEL, ...) = (void *)imp;
        long longResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithLong:longResult];
    }
    else if (strcmp("Q", retType) == 0)   // return unsigned long
    {
        unsigned long (*func)(id, SEL, ...) = (void *)imp;
        unsigned long longResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithUnsignedLong:longResult];
    }
    else if (strcmp("f", retType) == 0)   // return float
    {
        float (*func)(id, SEL, ...) = (void *)imp;
        float floatResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithFloat:floatResult];
    }
    else if (strcmp("d", retType) == 0)   // return double
    {
        double (*func)(id, SEL, ...) = (void *)imp;
        double doubleResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithDouble:doubleResult];
    }
    else if (strcmp("c", retType) == 0)   // return char
    {
        char (*func)(id, SEL, ...) = (void *)imp;
        char charResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithChar:charResult];
    }
    else if (strcmp("C", retType) == 0)   // return unsigned char
    {
        unsigned char (*func)(id, SEL, ...) = (void *)imp;
        unsigned char charResult = func(aOjbect, aSelector, params);
        return [NSNumber numberWithUnsignedChar:charResult];
    }
    return nil;
}

@end
