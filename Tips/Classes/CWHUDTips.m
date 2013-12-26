//
//  CWHUDTips.m
//  Tips
//
//  Created by ly on 13-12-20.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import "CWHUDTips.h"
#import "MBProgressHUD.h"

#define DefaultDismissTime      1.5

@interface CWHUDTips ()

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@end

@implementation CWHUDTips

+ (instancetype)sharedInstance
{
    static CWHUDTips *_hudTips = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _hudTips = [[CWHUDTips alloc] init];
    });
    return _hudTips;
}


#pragma mark - Actions

+ (void)showTips:(NSString *)tips
{
    [[CWHUDTips sharedInstance] showTips:tips];
}

+ (void)showLoadingTips:(NSString *)tips
{
    [[CWHUDTips sharedInstance] showLoadingTips:tips];
}

+ (void)hideTips
{
    [[CWHUDTips sharedInstance] hideTips];
}

- (void)showTips:(NSString *)tips
{
    [self showTips:tips withStatus:TipsStatusTextOnly dismissAfter:DefaultDismissTime];
}

- (void)showLoadingTips:(NSString *)tips
{
    [self showTips:tips withStatus:TipsStatusLoading dismissAfter:-1];
}

- (void)showTips:(NSString *)tips withStatus:(TipsStatusType)status dismissAfter:(NSTimeInterval)delay
{
    [self initializeProgressHud];
    
    // Configure mode
    [self configureProgressHudForStatus:status];
    
    // Set the tips
    self.progressHUD.labelText = tips;
    
    // Show
    [self.progressHUD show:YES];
    
    // Hide after `delay`
    if (delay > 0.0) {
        [self performSelector:@selector(hideTips) withObject:nil afterDelay:delay];
    }
}

- (void)hideTips
{
    [self hideTipsAnimated:YES];
}

- (void)hideTipsAnimated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:containerWindow() animated:animated];
    _progressHUD = nil;
}


#pragma mark - 

- (void)initializeProgressHud
{
    if ( _progressHUD && _progressHUD.superview) {
        [self hideTips];
        [CWHUDTips cancelPreviousPerformRequestsWithTarget:self];
    }
    [containerWindow() addSubview:self.progressHUD];
}

- (void)configureProgressHudForStatus:(TipsStatusType)status
{
    if ( TipsStatusTextOnly == status ) {
        self.progressHUD.mode = MBProgressHUDModeText;
    }
    else if (TipsStatusLoading == status ) {
        self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    }
    else {
        self.progressHUD.mode = MBProgressHUDModeText;
    }
}


#pragma mark - Property
- (MBProgressHUD *)progressHUD
{
    if ( _progressHUD == nil ) {
        _progressHUD = [[MBProgressHUD alloc] initWithWindow:containerWindow()];
        _progressHUD.removeFromSuperViewOnHide = YES;
        _progressHUD.userInteractionEnabled = NO;
    }
    return _progressHUD;
}


#pragma mark - Helper
static inline
UIWindow *containerWindow()
{
    UIWindow *window;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    if ([windows count] > 1) {
        window = [windows objectAtIndex:1];
    } else {
        window = [windows firstObject];
    }
    return window;
}

@end
