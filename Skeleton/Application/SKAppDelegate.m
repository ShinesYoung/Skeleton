//
//  SKAppDelegate.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKAppDelegate.h"

#import "UINavigationController+Skeleton.h"


@interface SKAppDelegate ()

@end



@implementation SKAppDelegate

/******************************************************************************/
/**** App UserNotification Method                                          ****/
/******************************************************************************/
#pragma mark -
#pragma mark App UserNotification Method


- (void)                application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSArray *moduleList = self.router.allModule;
    SEL selector = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:selector] )
        {
            [aModule                             application:application
            didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:( NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台)  */
- (void)         application:(UIApplication *)application
didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo
      fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    NSArray *moduleList = self.router.allModule;
    SEL selector = @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:);
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:selector])
        {
            [aModule          application:application
             didReceiveRemoteNotification:userInfo
                   fetchCompletionHandler:completionHandler];
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /// Background Fetch 恢复SDK 运行
    NSArray *moduleList = self.router.allModule;
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:@selector(application:performFetchWithCompletionHandler:)])
        {
            [aModule               application:application
             performFetchWithCompletionHandler:completionHandler];
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}




/******************************************************************************/
/**** Application openURL Method                                           ****/
/******************************************************************************/
#pragma mark -
#pragma mark Application openURL Method

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSArray *moduleList = self.router.allModule;
    for (SKModule *aModule in moduleList)
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
    NSArray *moduleList = self.router.allModule;
    for (SKModule *aModule in moduleList)
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
    NSArray *moduleList = self.router.allModule;
    SEL selector = @selector(application:openURL:sourceApplication:annotation:);
    for (SKModule *aModule in moduleList)
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
/**** Application Lifecycle Method                                         ****/
/******************************************************************************/
#pragma mark -
#pragma mark Application Lifecycle Method

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*** init Primary Elements of Application ****/
    self->_context     = [SKAppContext sharedContext];
    self->_environment = [SKEnvironment currentEnvironment];
    self->_router      = [SKRouter sharedRouter];
    
    
    /**** init key window begin ****/
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [UINavigationController new];
    [self.window makeKeyAndVisible];
    
    /**** call and launch all Module ****/
    NSArray *moduleList = self.router.allModule;
    NSLog(@"all mod : %@", moduleList);
    for (SKModule *aPlugin in moduleList)
    {
        if ([aPlugin respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
        {
            [aPlugin application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    NSArray *moduleList = self.router.allModule;
    
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:@selector(applicationWillResignActive:)])
        {
            [aModule applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSArray *moduleList = self.router.allModule;
    
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:@selector(applicationDidEnterBackground:)])
        {
            [aModule applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSArray *moduleList = self.router.allModule;
    
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:@selector(applicationWillEnterForeground:)])
        {
            [aModule applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSArray *moduleList = self.router.allModule;
    
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:@selector(applicationDidBecomeActive:)])
        {
            [aModule applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSArray *moduleList = self.router.allModule;
    for (SKModule *aModule in moduleList)
    {
        if ([aModule respondsToSelector:@selector(applicationWillTerminate:)])
        {
            [aModule applicationWillTerminate:application];
        }
    }
}

@end
