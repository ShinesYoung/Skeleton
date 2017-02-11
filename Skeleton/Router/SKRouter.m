//
//  SKRouter.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKRouter.h"

#import "UINavigationController+Skeleton.h"



@interface SKRouter ()

@property (nonatomic, strong, readonly) NSMutableArray *moduleList;
@property (nonatomic, strong, readonly) NSMutableDictionary *moduleMap;
@property (nonatomic, strong, readonly) NSMutableDictionary *strategyMap;


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
    
    [self.moduleList addObject:aModule];
    [self.moduleMap setValue:aModule forKey:[aModule moduleName]];
    
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
    
    NSLog(@"Module Register : %@", [aModule moduleName]);
    
    return YES;
}

- (BOOL)unregisterModule:(SKModule *)aModule
{
    if (self.moduleList)
    {
        if ([self.moduleList containsObject:aModule])
        {
            [self.moduleList removeObject:aModule];
        }
    }
    if (self.moduleMap)
    {
        if ([self.moduleMap valueForKey:[aModule moduleName]])
        {
            [self.moduleMap removeObjectForKey:[aModule moduleName]];
        }
    }
    return YES;
}

- (BOOL)unregisterModuleByName:(NSString *)moduleName
{
    SKModule *aModule = [self.moduleMap valueForKey:moduleName];
    if (self.moduleMap)
    {
        if (aModule)
        {
            [self.moduleMap removeObjectForKey:moduleName];
        }
    }
    if (self.moduleList)
    {
        if ([self.moduleList containsObject:aModule])
        {
            [self.moduleList removeObject:aModule];
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

- (void)registerStrategy:(id<SKRoutingStrategy>_Nonnull)aStrategy
{
    if (self.strategyMap && aStrategy)
    {
        [self.strategyMap setValue:aStrategy
                            forKey:[aStrategy strategyName]];
    }
}

- (void)unregisterStrategy:(NSString *_Nonnull)strategyName
{
    if (self.strategyMap && strategyName)
    {
        [self.strategyMap removeObjectForKey:strategyName];
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
    
    SEL selector = NSSelectorFromString(actionName);
    if (selector == nil || [aModule respondsToSelector:selector] == NO)
    {
        [self routeError:@"4041" errMsg:@"你请求的功能不存在"];
        return nil;
    }
    
    NSString *strategyName = [params valueForKey:kRouteStgy];
    if (strategyName == nil)
    {
        strategyName = vRouteStgyNameDefault;
    }
    
    id<SKRoutingStrategy> aStrategy = [self.strategyMap valueForKey:strategyName];
    
    return [aStrategy routing:aModule action:selector params:params];
    
}





/******************************************************************************/
/**** Route Page Function                                                  ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Page Function

- (UIViewController *)routePage:(NSString *_Nonnull)pageName
                       inModule:(NSString *_Nonnull)moduleName
                         params:(NSDictionary *_Nullable)params
{
    NSString *actionName = [NSString stringWithFormat:@"launch%@", pageName];
    
    id result = [self invokeModule:moduleName action:actionName params:params];
    if ([result isKindOfClass:[UIViewController class]])
    {
        return (UIViewController *)result;
    }
    return nil;
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
        [(UINavigationController *)rootVC routeError:@"4040" errMsg:@"你请求的模块不存在"];
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
    }
    return self;
}

@end
