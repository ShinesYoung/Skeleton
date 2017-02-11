//
//  SKPage.h
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKPage : UIViewController

@property (nonatomic, readonly, strong) NSString *pageId;

+ (NSString *)pageName;

@end
