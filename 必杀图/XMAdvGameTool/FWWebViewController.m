//
//  FWWebViewController.m
//  FWWebView
//
//  Created by zenox on 2018/1/2.
//  Copyright © 2018年 Asxce. All rights reserved.
//

#import "FWWebViewController.h"
#import "FWWebViewController+HUD.h"


@interface FWWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIView *webBar;

@property (weak, nonatomic) IBOutlet UIWebView *webV;

- (IBAction)back:(id)sender;

- (IBAction)come:(id)sender;

- (IBAction)refresh:(id)sender;

- (IBAction)home:(id)sender;

@end

@implementation FWWebViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.webV.delegate = self;
    NSURL *url = [NSURL URLWithString:self.Url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webV loadRequest:request];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

// 支持横屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.isMask) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}


- (IBAction)back:(id)sender {
      NSLog(@"%s",__func__);
    if ([self.webV canGoBack]) {
        [self.webV goBack];
    }
}

- (IBAction)come:(id)sender {
      NSLog(@"%s",__func__);
    if ([self.webV canGoForward]) {
        [self.webV goForward];
    }
}

- (IBAction)refresh:(id)sender {
    NSLog(@"%s",__func__);
    [self.webV reload];
}

- (IBAction)home:(id)sender {
    NSLog(@"%s",__func__);
    NSURL *url = [NSURL URLWithString:self.Url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webV loadRequest:request];
}



//
//
////注意，观察的移除
//-(void)dealloc{
//    [self.webV removeObserver:self forKeyPath:@"estimatedProgress"];
//    [self.webV removeObserver:self forKeyPath:@"title"];
//}
//
////开始加载
//-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    //开始加载的时候，让加载进度条显示
//    self.progressView.hidden = NO;
//
//}
//
////内容返回时调用
//-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//
//}
//
////服务器请求跳转的时候调用
//-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{}
//
////服务器开始请求的时候调用
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
////KVO监听进度条
////- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
////
////    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webV) {
////        [self.progressView setAlpha:1.0f];
////        BOOL animated = self.webV.estimatedProgress > self.progressView.progress;
////        [self.progressView setProgress:self.webV.estimatedProgress animated:animated];
////
////
////        if(self.webV.estimatedProgress >= 1.0f) {
////            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
////                [self.progressView setAlpha:0.0f];
////            } completion:^(BOOL finished) {
////                [self.progressView setProgress:0.0f animated:NO];
////            }];
////        }
////    }
////    else if ([keyPath isEqualToString:@"title"] && object == self.webV)
////    {
//////        self.title = self.webView.title;
////    }
////    else {
////        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
////    }
////}
//
//
//
//// 内容加载失败时候调用
//-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    NSLog(@"页面加载超时");
//}
//
////跳转失败的时候调用
//-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{}
//
//- (UIProgressView *)progressView{
//    if (!_progressView) {
//        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//
//        _progressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 5);
//
//        // 设置进度条的色彩
//        [_progressView setTrackTintColor:[UIColor whiteColor]];
//        _progressView.progressTintColor = [UIColor greenColor];
//    }
//    return _progressView;
//}
//
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHUD];
    
}

@end
