//
//  FWWebViewController+HUD.m
//  hatsune
//
//  Created by zenox on 2017/12/5.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "FWWebViewController+HUD.h"

@implementation FWWebViewController (HUD)
-(void)showSuccess:(NSString *)success
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.contentColor=[UIColor whiteColor];
    HUD.bezelView.color=[UIColor blackColor];
    HUD.mode=MBProgressHUDModeText;
    HUD.label.text=success;
    HUD.label.numberOfLines = 0;
    HUD.removeFromSuperViewOnHide=YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1];
}
-(void)showError:(NSString *)error
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.contentColor=[UIColor whiteColor];
    HUD.bezelView.color=[UIColor blackColor];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text=error;
    HUD.label.numberOfLines = 0;
    HUD.removeFromSuperViewOnHide=YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1];
}
-(void)showMessage:(NSString *)message
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.contentColor=[UIColor whiteColor];
    HUD.bezelView.color=[UIColor blackColor];
    HUD.mode=MBProgressHUDModeText;
    HUD.label.text=message;
    HUD.label.numberOfLines = 0;
    HUD.removeFromSuperViewOnHide=YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1];
}
-(void)showWaiting
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.contentColor=[UIColor whiteColor];
    HUD.removeFromSuperViewOnHide=YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
}
-(void)showLoading
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.backgroundView.color = [UIColor clearColor];
    HUD.bezelView.color = [UIColor clearColor];
    HUD.contentColor=[UIColor grayColor];
    HUD.label.text=@"正在加载";
    HUD.label.numberOfLines = 0;
    HUD.removeFromSuperViewOnHide=YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
}
-(void)showLoadingWithMessage:(NSString *)message
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.contentColor=[UIColor whiteColor];
    HUD.label.text=message;
    HUD.label.numberOfLines = 0;
    HUD.removeFromSuperViewOnHide=YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
}
-(void)showSaving
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    HUD.bezelView.color = [UIColor clearColor];
    HUD.contentColor=[UIColor whiteColor];
    HUD.label.text=@"正在保存";
    HUD.label.numberOfLines = 0;
    HUD.removeFromSuperViewOnHide=YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
}
-(void)hideHUD
{
    [MBProgressHUD hideHUDForView:[self getView] animated:YES];
}
-(UIView *)getView
{
    UIView *view;
    if (self.navigationController.view) {
        view=self.navigationController.view;
    }else
    {
        view=self.view;
    }
    return view;
}
@end
