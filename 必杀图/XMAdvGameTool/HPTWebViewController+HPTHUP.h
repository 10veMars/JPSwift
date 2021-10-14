//
//  HPTWebViewController+HPTHUP.h
//  VOFun
//
//  Created by zenox on 2018/2/1.
//  Copyright © 2018年 James Hicklin. All rights reserved.
//

#import "HPTWebViewController.h"

@interface HPTWebViewController (HPTHUP)
-(void)showSuccess:(NSString *)success;
-(void)showError:(NSString *)error;
-(void)showMessage:(NSString *)message;
-(void)showWaiting;
-(void)showLoadingHPT;
-(void)showLoadingWithMessage:(NSString *)message;
-(void)showSaving;
-(void)hideHUDHPT;
@end
