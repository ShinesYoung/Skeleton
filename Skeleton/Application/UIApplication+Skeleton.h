//
//  UIApplication+Skeleton.h
//  Skeleton
//
//  Created by WiLL on 2017/2/4.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKAppContext.h"
#import "SKEnvironment.h"
#import "SKRouter.h"


@interface UIApplication (Skeleton)

- (SKAppContext *)context;
- (SKEnvironment *)environment;
- (SKRouter *)router;

@end
