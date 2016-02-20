//
//  ViewController.m
//  Web
//
//  Created by 谢飞 on 16/2/20.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIWebView *web = [[UIWebView alloc]init];
    web.delegate = self;
    web.frame = self.view.bounds;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://club.eebbk.com/bbkbbs/showtopic/465102/1"]];
    [web loadRequest:request];
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML;"];
    
    if ([html containsString:@"http://club.eebbk.com/bbkbbs/showtopic/"]) {
        for (int i = 0; i<1000000; i++) {
            NSMutableArray *arr = [NSMutableArray array];
            arr addObject:<#(nonnull id)#>
        }
    }
    
    NSLog(@"%@",html);
    
}


@end
