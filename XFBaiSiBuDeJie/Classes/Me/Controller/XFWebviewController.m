//
//  XFWebviewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/4.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFWebviewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface XFWebviewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (nonatomic,strong)UIView *tabBar;
@property (nonatomic,strong)UIView *refreshView;
@property (nonatomic,strong)NJKWebViewProgress *progressProxy;
@property (nonatomic,strong)NJKWebViewProgressView *progressView;
@property (nonatomic,strong)UIButton *left;
@property (nonatomic,strong)UIButton *right;
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation XFWebviewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
   
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:YES];
}


- (NJKWebViewProgress *)_progressProxy{
    if (_progressProxy == nil) {
        _progressProxy = [[NJKWebViewProgress alloc]init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        
    }
    return _progressProxy;
}

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
        _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        _webView.delegate = self.progressProxy;
    }
    return _webView;
}

- (UIView *)tabBar{
    if (_tabBar == nil) {
        _tabBar = [[UIView alloc]init];
        _tabBar.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        _tabBar.backgroundColor = [UIColor whiteColor];
        
    }
    return _tabBar;
}

- (NJKWebViewProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[NJKWebViewProgressView alloc]init];
        if (_progressView.progress == 1) {
            _progressView.hidden = YES;
        }
        
    }
    return _progressView;
}


@end
