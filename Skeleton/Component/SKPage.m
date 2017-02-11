//
//  SKPage.m
//  Skeleton
//
//  Created by WiLL on 2017/2/10.
//  Copyright © 2017年 IDEA. All rights reserved.
//

#import "SKPage.h"

@interface SKPage ()

@end

@implementation SKPage

/******************************************************************************/
/**** Customzied Method                                                    ****/
/******************************************************************************/
#pragma mark -
#pragma mark Customzied Method

+ (NSString *)pageName
{
    return NSStringFromClass( [self class] );
}



/******************************************************************************/
/**** Default Lifecycle Method                                             ****/
/******************************************************************************/
#pragma mark -
#pragma mark Default Lifecycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
