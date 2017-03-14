//
//  SKModuleManager.h
//  Skeleton
//
//  Created by WiLL on 2017/3/9.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKModule.h"




@interface SKModuleManager : NSObject <UIApplicationDelegate>


/******************************************************************************/
/**** Customzied Method                                                    ****/
/******************************************************************************/
#pragma mark -
#pragma mark Customzied Method

- (void)registerModuleClass:(Class)moduleClass withName:(NSString *)moduleName;

- (void)unregisterModuleWithName:(NSString *)moduleName;

- (SKModule *)findModuleWithName:(NSString *)moduleName;



/******************************************************************************/
/**** Singleton Method                                                     ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singlton Method

+ (SKModuleManager *)sharedManager;

@end
