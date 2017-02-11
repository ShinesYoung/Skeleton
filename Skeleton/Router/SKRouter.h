//
//  SKRouter.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "SKModule.h"

@protocol SKRoutingStrategy <NSObject>

- (NSString *_Nonnull)strategyName;

- (id _Nullable)routing:(SKModule *_Nonnull)aModule
                 action:(SEL _Nonnull)aSelector
                 params:(NSDictionary *_Nullable)params;

@end



static NSString *_Nonnull const kPopToVC   = @"kPopToVC";
static NSString *_Nonnull const kRouteStgy = @"kRouteStgy";

static NSString *_Nonnull const vRouteStgyNameDefault          = @"Default";

static NSString *_Nonnull const vRouteStgyNameStackBottom      = @"StackBottom";
static NSString *_Nonnull const vRouteStgyNameStackTop         = @"StackTop";
static NSString *_Nonnull const vRouteStgyNameStackAboveBottom = @"StackAboveBottom";
static NSString *_Nonnull const vRouteStgyNameStackPushAbove   = @"StackPushAbove";

static NSString *_Nonnull const vRouteStgyNameData    = @"Data";
static NSString *_Nonnull const vRouteStgyNameRoot    = @"Root";
static NSString *_Nonnull const vRouteStgyNamePresent = @"Present";
static NSString *_Nonnull const vRouteStgyNameWindow  = @"Window";



/******************************************************************************/
/**** FFTRouter                                                            ****/
/**** It's the center route of Appliation. The application was comprised   ****/
/**** by some modules, The communication of modules was depended on the    ****/
/**** route. The FFTRoute is the only communication method between any     ****/
/**** modules. Never invocation another module directly in a module.       ****/
/******************************************************************************/
#pragma mark -
#pragma mark Class Define

@interface SKRouter : NSObject

/******************************************************************************/
/**** Module Register & Unregister Method                                  ****/
/******************************************************************************/
#pragma mark -
#pragma mark Module Register & Unregister Method

- (BOOL)registerModule:(SKModule * _Nonnull)aModule;
- (BOOL)unregisterModule:(SKModule * _Nonnull)aModule;
- (BOOL)unregisterModuleByName:(NSString * _Nonnull)moduleName;



/******************************************************************************/
/**** Module Access Method                                                 ****/
/******************************************************************************/
#pragma mark -
#pragma mark Module Access Method

- (NSArray *_Nonnull)allModule;

- (SKModule *_Nullable)moduleForName:(NSString *_Nonnull)moduleName;


/******************************************************************************/
/**** Strategy register & unregister Method                                ****/
/******************************************************************************/
#pragma mark -
#pragma mark Strategy register Method

- (void)registerStrategy:(id<SKRoutingStrategy>_Nonnull)aStrategy;
- (void)unregisterStrategy:(NSString *_Nonnull)strategyName;




/******************************************************************************/
/**** Module Invocate Function                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Module Invocate Function

- (id _Nullable)invokeModule:(NSString *_Nonnull)moduleName
                      action:(NSString *_Nonnull)actionName
                      params:(NSDictionary *_Nullable)params;




/******************************************************************************/
/**** Route Page Function                                                  ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Page Function

- (UIViewController *_Nullable)routePage:(NSString *_Nonnull)pageName
                                inModule:(NSString *_Nonnull)moduleName
                                  params:(NSDictionary *_Nullable)params;




/******************************************************************************/
/**** Route Error Function                                                 ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Error Function

- (void)routeError:(NSString *_Nullable)errCode
            errMsg:(NSString *_Nullable)errMsg;


/******************************************************************************/
/**** Singleton Method                                                     ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singleton Method

+ (SKRouter * _Nonnull)sharedRouter;



@end
