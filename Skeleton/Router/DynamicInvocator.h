//
//  DynamicInvocator.h
//  Skeleton
//
//  Created by yangshansi on 2017/5/24.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface DynamicInvocator : NSObject

- (id)inovkeClassName:(NSString *)className methodName:(NSString *)methodName;

- (id)invokeClass:(Class)aClass method:(Method)aMethod;

- (id)invokeInstance:(id)aOjbect selector:(SEL)aSelector;

- (id)invokeInstance:(id)aOjbect selector:(SEL)aSelector params:(NSDictionary *)params;

- (id)invokeObject:(id)aObject selector:(SEL)aSelector
        returnType:(unsigned char)returnType
   typeOfArguments:(NSArray *)typeOfArguments
         arguments:(NSArray *)arguments;

@end
