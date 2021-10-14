//
//  FWWebViewController.h
//  FWWebView
//
//  Created by zenox on 2018/1/2.
//  Copyright © 2018年 Asxce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJProgressHUD.h"

@interface FWWebViewController : UIViewController
@property (nonatomic,assign) BOOL isShow;

@property (nonatomic,assign) BOOL isMask;

@property (nonatomic,strong) NSString *Url;
@end
