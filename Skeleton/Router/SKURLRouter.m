//
//  SKOpenURLModule.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKURLRouter.h"

#import "SKRouter.h"
#import "UIApplication+Skeleton.h"



@implementation SKURLRouter

/******************************************************************************/
/**** Module Loading method                                                ****/
/******************************************************************************/
#pragma mark -
#pragma mark Module Loading method

+ (void)load
{
    [[SKRouter sharedRouter] registerModule:[SKURLRouter new]];
}


/******************************************************************************/
/**** Static Customzied Method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Static Customzied Method

+ (NSString *)appScheme
{
    NSString *appScheme = @"default";
    
    NSArray *urlTypes = [UIApplication sharedApplication].environment.urlTypes;
    for (NSDictionary *aUrlType in urlTypes)
    {
        NSString *urlName = [aUrlType valueForKey:@"CFBundleURLName"];
        if ([urlName isEqualToString:@"AppScheme"])
        {
            NSArray *schemes = [aUrlType valueForKey:@"CFBundleURLSchemes"];
            if (schemes && schemes.count > 0)
            {
                appScheme = schemes.firstObject;
                break;
            }
        }
    }
    return appScheme;
}



/******************************************************************************/
/**** Customzied Method                                                    ****/
/******************************************************************************/
#pragma mark -
#pragma mark Customzied Method

- (BOOL)processOpenURL:(NSURL *)url
{
    
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    NSString *path = url.path;
    NSString *query = url.query;
    
    
    
    NSLog(@"URL handle %@://%@%@?%@", scheme, host, path, query);
    
    // parse path
    path = [url.path substringFromIndex:1]; // remove first slash
    
    
    // parse query
    NSArray *queryComponents = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    for (NSString *aQueryComponent in queryComponents)
    {
        if ( [aQueryComponent containsString:@"="])
        {
            NSArray *paramPair = [aQueryComponent componentsSeparatedByString:@"="];
            
            // url decode
            NSString *paramValue = [paramPair[1] stringByRemovingPercentEncoding];
            [paramDic setValue:paramValue forKey:paramPair[0]];
        }
    }
    
    NSLog(@"Parse paramDic : %@", paramDic);
    
    [[SKRouter sharedRouter] invokeModule:host action:path params:paramDic];
    
    
    return YES;
}


/******************************************************************************/
/**** UIApplication Delegate Method                                        ****/
/******************************************************************************/
#pragma mark -
#pragma mark UIApplication Delegate method

// iOS 9.0 below
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[SKURLRouter appScheme] isEqualToString:url.scheme])
    {
        return YES;
    }
    return NO;
}

// iOS 9.0 below
-(BOOL) application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([[SKURLRouter appScheme] isEqualToString:url.scheme])
    {
        return [self processOpenURL:url];
    }
    return NO;
}

// iOS 9.0 above
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options
{
    if ([[SKURLRouter appScheme] isEqualToString:url.scheme])
    {
        return [self processOpenURL:url];
    }
    return NO;
}


@end
