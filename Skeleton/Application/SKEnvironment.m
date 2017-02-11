//
//  SKEnvironment.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKEnvironment.h"

#include <sys/types.h>
#include <sys/sysctl.h>



@implementation SKEnvironment

/******************************************************************************/
/**** Singleton Method                                                     ****/
/******************************************************************************/
#pragma mark -
#pragma mark Singlton Method

+ (SKEnvironment *)currentEnvironment
{
    static SKEnvironment *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [SKEnvironment new];
    });
    
    return instance;
}



/******************************************************************************/
/**** Customzied Method                                                    ****/
/******************************************************************************/
#pragma mark -
#pragma mark Customzied Method

- (NSString *)platform
{
    return @"Apple";
}

- (NSString *)deviceId
{
    //NSString *deviceId = [SSKeyChain load:@"deviceId"];
    NSString *deviceId = nil;
    if (deviceId == nil || [deviceId isEqualToString:@""] ||
        [deviceId isKindOfClass:[NSNull class]])
    {
        deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        //[SSKeyChain save:@"deviceId" data:deviceId];
    }
    
    return deviceId;
}

- (NSString *)deviceType
{
    NSDictionary *typeDic = @{@"iPhone1,1" : @"iPhone 2G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (CMCC,UNICOM)",
                              @"iPhone3,2" : @"iPhone 4 (UNICOM)",
                              @"iPhone3,3" : @"iPhone 4 (TELECOM)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5 (GSM)",
                              @"iPhone5,2" : @"iPhone 5 (GSM+CDMA)",
                              @"iPhone5,3" : @"iPhone 5C (GSM)",
                              @"iPhone5,4" : @"iPhone 5C (GSM+CDMA)",
                              @"iPhone6,1" : @"iPhone 5S (GSM)",
                              @"iPhone6,2" : @"iPhone 5S (GSM+CDMA)",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6S",
                              @"iPhone8,2" : @"iPhone 6S Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              
                              @"iPod1,1"   : @"iPod Touch 1G",
                              @"iPod2,1"   : @"iPod Touch 2G",
                              @"iPod3,1"   : @"iPod Touch 3G",
                              @"iPod4,1"   : @"iPod Touch 4G",
                              @"iPod5,1"   : @"iPod Touch 5G",
                              
                              @"iPad1,1"   : @"iPad 1",
                              @"iPad2,1"   : @"iPad 2 (WIFI)",
                              @"iPad2,2"   : @"iPad 2 (GSM)",
                              @"iPad2,3"   : @"iPad 2 (CDMA)",
                              @"iPad2,4"   : @"iPad 2 (32nm)",
                              @"iPad2,5"   : @"iPad Mini (WIFI)",
                              @"iPad2,6"   : @"iPad Mini (GSM)",
                              @"iPad2,7"   : @"iPad Mini (CDMA)",
                              @"iPad3,1"   : @"iPad 3 (WIFI)",
                              @"iPad3,2"   : @"iPad 3 (CDMA)",
                              @"iPad3,3"   : @"iPad 3 (4G)",
                              @"iPad3,4"   : @"iPad 4 (WIFI)",
                              @"iPad3,5"   : @"iPad 4 (4G)",
                              @"iPad3,6"   : @"iPad 4 (CDMA)",
                              @"iPad4,1"   : @"iPad Air",
                              @"iPad4,2"   : @"iPad Air",
                              @"iPad4,4"   : @"iPad Mini 2G",
                              @"iPad4,5"   : @"iPad Mini 2G",
                              @"iPad4,6"   : @"iPad Mini 2G",
                              
                              @"i386"      : @"iPhoneSimulator",
                              @"x86_64"    : @"iPhoneSimulator"};
    
    
    NSString *platform = [self machineCode];
    
    NSString *deviceModel = typeDic[platform];
    
    return (deviceModel == nil) ? platform : deviceModel;
}

- (NSString *)osName
{
    return [[UIDevice currentDevice] systemName];
}

- (NSString *)osVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)appVersionString
{
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary]
                               valueForKey:@"CFBundleShortVersionString"];
    return versionString;
}

- (NSString *_Nullable)appVersionCode
{
    NSString *versionCode = [[[NSBundle mainBundle] infoDictionary]
                             valueForKey:@"CFBundleVersion"];
    return versionCode;
}

- (NSString *)appBundleId
{
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    return bundleId;
}

- (NSString *)appBundleName
{
    NSString *bundleName = [[[NSBundle mainBundle] infoDictionary]
                            valueForKey:@"CFBundleName"];
    return bundleName;
}

- (NSString *)machineCode
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *typeCode = [NSString stringWithCString:machine
                                            encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return typeCode;
}

- (NSArray *)urlTypes
{
    NSArray *urlTypes = [[[NSBundle mainBundle] infoDictionary]
                         valueForKey:@"CFBundleURLTypes"];
    return urlTypes;
}




/******************************************************************************/
/**** Default Lifecycle Method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Default Lifecycle Method

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
