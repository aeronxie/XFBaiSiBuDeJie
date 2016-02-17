//
//  XFMeViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/17.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFMeViewController.h"



@interface XFMeViewController ()
@property (nonatomic,strong) UIButton *moonBtn;
@property (nonatomic,strong) UIButton *settingBtn;
@end

@implementation XFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    self.title = @"我的";
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc]initWithCustomView:self.settingBtn],
                                                [[UIBarButtonItem alloc]initWithCustomView:self.moonBtn]
                                                ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)moonBtn{
    if (_moonBtn == nil) {
        _moonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moonBtn setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
        [_moonBtn setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
        _moonBtn.size = _moonBtn.currentBackgroundImage.size;
        
    }
    return _moonBtn;
}

- (UIButton *)settingBtn{
    if (_settingBtn == nil) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
        _settingBtn.size = _settingBtn.currentBackgroundImage.size;
        
    }
    return _settingBtn;
}


@end
