//
//  SKRoutingStrategy.h
//  Skeleton
//
//  Created by Shines Young on 2017/2/27.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *_Nonnull const kPopToVC   = @"kPopToVC";
static NSString *_Nonnull const kRouteStgy = @"kRouteStgy";

static NSString *_Nonnull const vStgyNameDefault          = @"Default";

static NSString *_Nonnull const vStgyNameStackBottom      = @"StackBottom";
static NSString *_Nonnull const vStgyNameStackTop         = @"StackTop";
static NSString *_Nonnull const vStgyNameStackAboveBottom = @"StackAboveBottom";
static NSString *_Nonnull const vStgyNameStackPushAbove   = @"StackPushAbove";

static NSString *_Nonnull const vStgyNameSubview = @"Subview";
static NSString *_Nonnull const vStgyNameRoot    = @"Root";
static NSString *_Nonnull const vStgyNamePresent = @"Present";
static NSString *_Nonnull const vStgyNameWindow  = @"Window";



@protocol SKRoutingStrategy <NSObject>

+ (NSString *_Nonnull)strategyName;

+ (BOOL)routingData:(id _Nonnull)data params:(NSDictionary *_Nullable)params;

@end
