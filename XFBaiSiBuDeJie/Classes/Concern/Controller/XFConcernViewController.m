//
//  XFConcernViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/17.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFConcernViewController.h"
#import "XFRecommendViewController.h"
#import "XFLoginViewController.h"

@interface XFConcernViewController ()
@property (nonatomic,strong) UIButton *recommandBtn;
@end

@implementation XFConcernViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundColor;
    [self setupNavBar];
}

- (IBAction)loginBtn:(UIButton *)sender {
    
    XFLoginViewController *loginVc = [[XFLoginViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:nil];
    
}

- (IBAction)registerBtn:(UIButton *)sender {
    XFLoginViewController *loginVc = [[XFLoginViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:nil];


}

//设置导航条
- (void)setupNavBar
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.recommandBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)recommandBtn {
    if (_recommandBtn == nil) {
        _recommandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recommandBtn setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
        [_recommandBtn setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
        _recommandBtn.size = _recommandBtn.currentBackgroundImage.size;
        [[_recommandBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            XFRecommendViewController *rcVc = [[XFRecommendViewController alloc]init];
            [self.navigationController pushViewController:rcVc animated:YES];
        }];
        
    }
    return _recommandBtn;
}

@end
