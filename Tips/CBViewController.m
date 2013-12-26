//
//  CBViewController.m
//  Tips
//
//  Created by ly on 13-12-20.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import "CBViewController.h"
#import "CWHUDTips.h"

@interface CBViewController ()

@end

@implementation CBViewController


#pragma mark - Actions

- (IBAction)showText:(id)sender
{
    [CWHUDTips showTips:@"自动隐藏的文字"];
}

- (IBAction)showLoading:(id)sender
{
    [CWHUDTips showLoadingTips:@"加载中..."];
}

- (IBAction)hide:(id)sender
{
    [CWHUDTips hideTips];
}

@end
