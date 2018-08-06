//
//  SKRouter.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKRouter.h"

#import "UINavigationController+Skeleton.h"
#import "DynamicInvocator.h"



@interface SKRouter ()

@property (nonatomic, strong, readonly) NSMutableArray *moduleList;
@property (nonatomic, strong, readonly) NSMutableDictionary *moduleMap;
@property (nonatomic, strong, readonly) NSMutableDictionary *strategyMap;

@property (nonatomic, strong, readonly) DynamicInvocator *invocator;

@end




#pragma mark -
#pragma mark Class Implement


@implementation SKRouter

/******************************************************************************/
/**** Module Register & Unregister Method                                  ****/
/******************************************************************************/
#pragma mark -
#pragma mark Module Register & Unregister Method

- (BOOL)registerModule:(SKModule *)aModule;
{
    if (aModule == nil || [aModule isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    
    @synchronized (self.moduleList)
    {
        [self.moduleList addObject:aModule];
        [self.moduleList sortUsingComparator:
         ^NSComparisonResult(SKModule *_Nonnull module1,
                             SKModule *_Nonnull module2)
         {
             if ([module1 moduleLevel] > [module2 moduleLevel])
             {
                 return (NSComparisonResult)NSOrderedDescending;
             }
             if ([module1 moduleLevel] < [module2 moduleLevel])
             {
                 return (NSComparisonResult)NSOrderedAscending;
             }
             return (NSComparisonResult)NSOrderedSame;
         }];
        
    }
    
    @synchronized (self.moduleMap)
    {
        [self.moduleMap setValue:aModule forKey:[aModule moduleName]];
    }
    
    
    NSLog(@"Module Register : %@", [aModule moduleName]);
    
    return YES;
}

- (BOOL)unregisterModule:(SKModule *)aModule
{
    @synchronized (self.moduleList)
    {
        if (self.moduleList)
        {
            if ([self.moduleList containsObject:aModule])
            {
                [self.moduleList removeObject:aModule];
            }
        }
    }
    
    @synchronized (self.moduleMap)
    {
        if (self.moduleMap)
        {
            if ([self.moduleMap valueForKey:[aModule moduleName]])
            {
                [self.moduleMap removeObjectForKey:[aModule moduleName]];
            }
        }
    }
    
    return YES;
}

- (BOOL)unregisterModuleByName:(NSString *)moduleName
{
    SKModule *aModule = [self.moduleMap valueForKey:moduleName];
    
    @synchronized (self.moduleList)
    {
        if (self.moduleList)
        {
            if ([self.moduleList containsObject:aModule])
            {
                [self.moduleList removeObject:aModule];
            }
        }
    }

    @synchronized (self.moduleMap)
    {
        if (self.moduleMap)
        {
            if (aModule)
            {
                [self.moduleMap removeObjectForKey:moduleName];
            }
        }
    }
    
    
    return YES;
}




/******************************************************************************/
/**** Module Access Method                                                 ****/
/******************************************************************************/
#pragma mark -
#pragma mark Module Access Method

- (NSArray *)allModule
{
    return self.moduleList;
}

- (SKModule *)moduleForName:(NSString *)moduleName
{
    return [self.moduleMap valueForKey:moduleName];
}




/******************************************************************************/
/**** Strategy register & unregister Method                                ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy register & unregister Method

- (void)registerStrategy:(Class _Nonnull)aStgyClass
{
    @synchronized (self.strategyMap)
    {
        if (self.strategyMap && aStgyClass)
        {
            [self.strategyMap setValue:aStgyClass
                                forKey:[aStgyClass strategyName]];
        }
    }
}

- (void)unregisterStrategy:(NSString *_Nonnull)strategyName
{
    @synchronized (self.strategyMap)
    {
        if (self.strategyMap && strategyName)
        {
            [self.strategyMap removeObjectForKey:strategyName];
        }
    }
}

- (Class)strategyForName:(NSString *)aStrgyName
{
    @synchronized (self.strategyMap)
    {
        return [self.strategyMap valueForKey:aStrgyName];
    }
}




/******************************************************************************/
/**** Module Invocate Function                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Module Invocate Function

- (id)invokeModule:(NSString *_Nonnull)moduleName
            action:(NSString *_Nonnull)actionName
            params:(NSDictionary *_Nullable)params
{
    SKModule *aModule = [self moduleForName:moduleName];
    if (aModule == nil)
    {
        [self routeError:@"4040" errMsg:@"你请求的模块不存在"];
        return nil;
    }
    
    SEL aSelector = NSSelectorFromString(actionName);
    if (aSelector == nil || [aModule respondsToSelector:aSelector] == NO)
    {
        [self routeError:@"4041" errMsg:@"你请求的功能不存在"];
        return nil;
    }
    
//    NSLog(@"Router get params %@", params);
    
    id data = [self.invocator invokeInstance:aModule
                                    selector:aSelector
                                      params:params];
    
//    NSLog(@"Router get result %@", data);
    
    // get strategy
    NSString *aStrgyName = [params valueForKey:kRouteStgy];
    if (aStrgyName == nil)
    {
        aStrgyName = vStgyNameDefault;
    }
    
//    NSLog(@"Router get strgyName %@", aStrgyName);
    Class aStrgyClass = [self strategyForName:aStrgyName];
    if (aStrgyClass == nil)
    {
        [self routeError:@"4042" errMsg:@"你请求的路由不存在"];
        return nil;
    }
    
    BOOL routeResult = [aStrgyClass routingData:data params:params];
    NSLog(@"Routing Result %@", routeResult ? @"Y" : @"N");
    
    return data;
}





/******************************************************************************/
/**** Route Page Function                                                  ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Page Function

- (id)routePage:(UIViewController *)aPage params:(NSDictionary *)params
{
    if (aPage == nil || [aPage isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    NSString *aStrgyName = [params valueForKey:kRouteStgy];
    if (aStrgyName == nil)
    {
        aStrgyName = vStgyNameDefault;
    }
    
    Class aStrgyClass = [self strategyForName:aStrgyName];
    if (aStrgyClass == nil)
    {
        [self routeError:@"4042" errMsg:@"你请求的路由不存在"];
        return nil;
    }
    
    BOOL routeResult = [aStrgyClass routingData:aPage params:params];
    NSLog(@"Routing Result %@", routeResult ? @"Y" : @"N");
    
    return aPage;
}








/******************************************************************************/
/**** Route Error Function                                                 ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Error Function

- (void)routeError:(NSString *)errCode errMsg:(NSString *)errMsg
{
    // get rootVC
    UIViewController *rootVC
    = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //
    if (rootVC == nil)
    {
        
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)rootVC routeError:errCode errMsg:errMsg];
    }
    else if ([rootVC isKindOfClass:[UIViewController class]])
    {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"错误"
                                    message:errMsg
                                    preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *confirm = [UIAlertAction
                                  actionWithTitle:@"确认"
                                  style:(UIAlertActionStyleCancel)
                                  handler:^(UIAlertAction * _Nonnull action)
                                  {
                                      
                                  }];
        [alert addAction:confirm];
        
        [rootVC presentViewController:alert animated:YES completion:nil];
    }
}



/******************************************************************************/
/**** Parameters Injection Function                                        ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Error Function

- (void)injectParams:(NSDictionary *)params inObject:(NSObject *)aObj
{
    if ([aObj isKindOfClass:[NSObject class]] == NO)
    {
        return;
    }
    
    for (NSString *aKey in params.allKeys)
    {
        id value = [aObj valueForKey:aKey];
        NSLog(@"KVC check : value=%@", value);
        
        NSString *aValue = [params valueForKey:aKey];
        NSLog(@"aK=%@ aV=%@",aKey, aValue);
        SEL aSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
                                              [[aKey substringToIndex:1] uppercaseString],
                                              [aKey substringFromIndex:1]]);
        if ([aObj respondsToSelector:aSelector])
        {
            [aObj setValue:aValue forKey:aKey];
        }
        
    }
}



/******************************************************************************/
/**** Singleton Method                                                     ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singleton Method

+ (SKRouter *)sharedRouter
{
    static SKRouter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void)
    {
        instance = [SKRouter new];
    });
    return instance;
}



/******************************************************************************/
/**** Default Lifecycle Method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Default Lifecycle Method

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self->_moduleList = [NSMutableArray new];
        self->_moduleMap = [NSMutableDictionary new];
        self->_strategyMap = [NSMutableDictionary dictionary];
        self->_invocator = [DynamicInvocator new];
    }
    return self;
}

@end
