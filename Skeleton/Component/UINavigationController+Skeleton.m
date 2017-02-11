//
//  UINavigationController+Skeleton.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "UINavigationController+Skeleton.h"

@implementation UINavigationController (Skeleton)

/******************************************************************************/
/**** Customzied Method                                                    ****/
/******************************************************************************/
#pragma mark -
#pragma mark Customzied Method

- (void)routeError:(NSString *)errCode errMsg:(NSString *)errMsg
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"错误"
                                message:errMsg
                                preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *confirm = [UIAlertAction
                              actionWithTitle:@"确认"
                              style:(UIAlertActionStyleCancel)
                              handler:^(UIAlertAction * _Nonnull action)
                              {
                                  
                              }];
    [alert addAction:confirm];
    
    [self presentViewController:alert animated:YES completion:nil];
}




/******************************************************************************/
/**** UINavigationController Delegate Declaration                          ****/
/******************************************************************************/
#pragma mark -
#pragma mark UINavigationController Delegate Declaration

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    NSLog(@"Skeleton Stack : \n%@", self.viewControllers);
}


/******************************************************************************/
/**** Default Lifecycle Method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Default Lifecycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarHidden:YES animated:NO];
    self.delegate = self;
    
}


@end
