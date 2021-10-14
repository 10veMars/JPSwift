//
//  FWWebViewController+HUD.h
//  hatsune
//
//  Created by zenox on 2017/12/5.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "FWWebViewController.h"

@interface FWWebViewController (HUD)
-(void)showSuccess:(NSString *)success;
-(void)showError:(NSString *)error;
-(void)showMessage:(NSString *)message;
-(void)showWaiting;
-(void)showLoading;
-(void)showLoadingWithMessage:(NSString *)message;
-(void)showSaving;
-(void)hideHUD;
@end
