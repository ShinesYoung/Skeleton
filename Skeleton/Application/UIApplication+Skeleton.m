//
//  UIApplication+Skeleton.m
//  Skeleton
//
//  Created by WiLL on 2017/2/4.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "UIApplication+Skeleton.h"

#import "SKAppDelegate.h"



@implementation UIApplication (Skeleton)

- (SKAppContext *)context
{
    SKAppDelegate *delegate = (SKAppDelegate *)self.delegate;
    
    return delegate.context;
}

- (SKEnvironment *)environment
{
    SKAppDelegate *delegate = (SKAppDelegate *)self.delegate;
    
    return delegate.environment;
}

- (SKRouter *)router
{
    SKAppDelegate *delegate = (SKAppDelegate *)self.delegate;
    
    return delegate.router;
}

@end
