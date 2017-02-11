//
//  SKEnvironment.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKEnvironment : NSObject

/******************************************************************************/
/**** Singleton Method                                                     ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singlton Method

+ (SKEnvironment *)currentEnvironment;



/******************************************************************************/
/**** Customzied Method                                                    ****/
/******************************************************************************/
#pragma mark -
#pragma mark Customzied Method

- (NSString *)platform;
- (NSString *)deviceId;
- (NSString *)deviceType;
- (NSString *)osName;
- (NSString *)osVersion;
- (NSString *)appVersionString;
- (NSString *)appVersionCode;
- (NSString *)appBundleId;
- (NSString *)appBundleName;
- (NSArray *)urlTypes;


@end
