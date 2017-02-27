//
//  SKRouter.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKRoutingStrategy.h"

#import "SKModule.h"


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

- (void)registerStrategy:(Class _Nonnull)aStgyClass;
- (void)unregisterStrategy:(NSString *_Nonnull)aStrgyName;
- (Class _Nullable)strategyForName:(NSString *_Nonnull)aStrgyName;




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

- (id _Nullable)routePage:(UIViewController *_Nonnull)aPage
                   params:(NSDictionary *_Nullable)params;




/******************************************************************************/
/**** Route Error Function                                                 ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Error Function

- (void)routeError:(NSString *_Nullable)errCode
            errMsg:(NSString *_Nullable)errMsg;



/******************************************************************************/
/**** Parameters Injection Function                                        ****/
/******************************************************************************/
#pragma mark -
#pragma mark Route Error Function

- (void)injectParams:(NSDictionary *_Nullable)params
            inObject:(NSObject *_Nullable)aObj;


/******************************************************************************/
/**** Singleton Method                                                     ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singleton Method

+ (SKRouter * _Nonnull)sharedRouter;



@end
