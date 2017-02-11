//
//  SKModule.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define fft_module_level_default    0
#define fft_module_level_thirdParty 1000
#define fft_module_level_utility    2000
#define fft_module_level_business   3000



@interface SKModule : NSObject <UIApplicationDelegate>

- (NSString *)moduleName;

- (NSInteger)moduleLevel;

@end
