//
//  XFEssenceViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/17.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFEssenceViewController.h"
#import "XFConcernViewController.h"

@interface XFEssenceViewController ()
@property (nonatomic,strong) UIButton *naviLeftBtn;
@end

@implementation XFEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.view.backgroundColor = GLOBALCOLOR(arc4random_uniform(255)/255.0, arc4random_uniform(255)/255.0, arc4random_uniform(255)/255.0, 1)
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.naviLeftBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIButton *)naviLeftBtn{
    if (_naviLeftBtn == nil) {
        _naviLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_naviLeftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
        [_naviLeftBtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
        _naviLeftBtn.size = _naviLeftBtn.currentBackgroundImage.size;
    
        [[_naviLeftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
#warning no use
            XFConcernViewController *vc = [[XFConcernViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _naviLeftBtn;
}

@end

