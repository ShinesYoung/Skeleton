//
//  SKAppDelegate.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SKAppContext.h"
#import "SKEnvironment.h"
#import "SKRouter.h"



@interface SKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) SKAppContext  *context;
@property (nonatomic, strong, readonly) SKEnvironment *environment;
@property (nonatomic, strong, readonly) SKRouter      *router;

@end
