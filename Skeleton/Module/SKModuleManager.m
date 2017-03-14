//
//  SKModuleManager.m
//  Skeleton
//
//  Created by WiLL on 2017/3/9.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKModuleManager.h"

@interface SKModuleManager () 

@property (nonatomic, strong, readonly) NSMutableDictionary *registeredModuleMap;
@property (nonatomic, strong, readonly) NSMutableArray      *allModules;

// application lifecycle watchers
@property (nonatomic, strong, readonly) NSMutableArray *modulesOfFinishLaunch;
@property (nonatomic, strong, readonly) NSMutableArray *modulesOfTerminate;
@property (nonatomic, strong, readonly) NSMutableArray *modulesOfBecomeActive;
@property (nonatomic, strong, readonly) NSMutableArray *modulesOfResignActvie;
@property (nonatomic, strong, readonly) NSMutableArray *modulesOfEnterBackground;
@property (nonatomic, strong, readonly) NSMutableArray *modulesOfEnterForeground;

// application openurl watcher
@property (nonatomic, strong, readonly) NSMutableArray *modulesOfOpenURL;



@end



@implementation SKModuleManager






/******************************************************************************/
/**** Customzied Method                                                    ****/
/******************************************************************************/
#pragma mark -
#pragma mark Customzied Method

- (void)registerModuleClass:(Class)moduleClass withName:(NSString *)moduleName
{
    
}

- (void)unregisterModuleWithName:(NSString *)moduleName
{
    
}

- (SKModule *)findModuleWithName:(NSString *)moduleName
{
    
}




/******************************************************************************/
/**** UIApplication Delegate Method - Lifecycle                            ****/
/******************************************************************************/
#pragma mark -
#pragma mark UIApplication Delegate method (Lifecycle)

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    for (SKModule *aModule in self.modulesOfFinishLaunch)
    {
        if ([aModule respondsToSelector:@selector(applicationWillResignActive:)])
        {
            [aModule applicationWillResignActive:application];
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    for (SKModule *aModule in self.modulesOfResignActvie)
    {
        if ([aModule respondsToSelector:@selector(applicationWillResignActive:)])
        {
            [aModule applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (SKModule *aModule in self.modulesOfEnterBackground)
    {
        if ([aModule respondsToSelector:@selector(applicationDidEnterBackground:)])
        {
            [aModule applicationDidEnterBackground:application];
        }
    }

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (SKModule *aModule in self.modulesOfEnterForeground)
    {
        if ([aModule respondsToSelector:@selector(applicationWillEnterForeground:)])
        {
            [aModule applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    for (SKModule *aModule in self.modulesOfBecomeActive)
    {
        if ([aModule respondsToSelector:@selector(applicationDidBecomeActive:)])
        {
            [aModule applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    for (SKModule *aModule in self.modulesOfTerminate)
    {
        if ([aModule respondsToSelector:@selector(applicationDidBecomeActive:)])
        {
            [aModule applicationDidBecomeActive:application];
        }
    }
}



/******************************************************************************/
/**** UIApplication Delegate Method - Lifecycle                            ****/
/******************************************************************************/
#pragma mark -
#pragma mark UIApplication Delegate method (Lifecycle)

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    for (SKModule *aModule in self.modulesOfOpenURL)
    {
        if ([aModule respondsToSelector:@selector(application:openURL:options:)])
        {
            [aModule application:application openURL:url options:options];
        }
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    for (SKModule *aModule in self.modulesOfOpenURL)
    {
        if ([aModule respondsToSelector:@selector(application:handleOpenURL:)])
        {
            [aModule application:application handleOpenURL:url];
        }
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    SEL selector = @selector(application:openURL:sourceApplication:annotation:);
    for (SKModule *aModule in self.modulesOfOpenURL)
    {
        if ([aModule respondsToSelector:selector])
        {
            [aModule application:application openURL:url
               sourceApplication:sourceApplication
                      annotation:annotation];
        }
    }
    
    return YES;
}




/******************************************************************************/
/**** Singleton Method                                                     ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singlton Method

+ (SKModuleManager *)sharedManager
{
    static SKModuleManager *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [SKModuleManager new];
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
        
        
        self->_modulesOfFinishLaunch    = [NSMutableArray new];
        self->_modulesOfResignActvie    = [NSMutableArray new];
        self->_modulesOfEnterBackground = [NSMutableArray new];
        self->_modulesOfEnterForeground = [NSMutableArray new];
        self->_modulesOfBecomeActive    = [NSMutableArray new];
        self->_modulesOfTerminate       = [NSMutableArray new];
    }
    return self;
}




@end
