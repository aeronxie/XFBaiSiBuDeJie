//
//  XFMeViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/17.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFMeViewController.h"
#import "XFMeCell.h"
#import "XFSquareCell.h"
#import "XFSquare.h"
#import "XFSquareTool.h"
#import "XFSquareFooterView.h"

static NSString *const meCellID = @"me";
static NSString *const squareCellID = @"square";
@interface XFMeViewController ()<UITableViewDataSource>
@property (nonatomic,strong) UIButton *moonBtn;
@property (nonatomic,strong) UIButton *settingBtn;
@property (nonatomic,strong) XFSquareTool *tool;
@property (nonatomic,strong) UIButton *btnRight;
@property (nonatomic,strong) UIButton *btnLeft;
@property (nonatomic,strong) UIView *verticalLine;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation XFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   
        [self setNaviItems];
        [self setupTableView];

}

//设置tableView
-(void)setupTableView {
    
    [self.view addSubview:self.tableView];
    // 设置背景色
    self.tableView.backgroundColor = BackgroundColor;
    [self.tableView registerClass:[XFMeCell class] forCellReuseIdentifier:meCellID];
    [self.tableView registerClass:[XFSquareCell class] forCellReuseIdentifier:squareCellID];
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    self.tableView.tableFooterView = [[XFSquareFooterView alloc]init];
    
    //frame 刚开始是0
    [[RACObserve(self.tableView.tableFooterView, frame) distinctUntilChanged] subscribeNext:^(id x) {
        self.tableView.tableFooterView = self.tableView.tableFooterView;
    }];

}

//设置导航按钮
-(void)setNaviItems {
    
    self.title = @"我的";
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc]initWithCustomView:self.settingBtn],
                                                [[UIBarButtonItem alloc]initWithCustomView:self.moonBtn]
                                                ];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 2) {
        [cell addSubview:self.btnLeft];
        [cell addSubview:self.btnRight];
        [cell addSubview:self.verticalLine];
    }
    return cell;
}


#pragma mark - getter and setter

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

- (UIButton *)btnLeft{
    if (_btnLeft == nil) {
        _btnLeft = [[UIButton alloc]init];
        _btnLeft.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
        [_btnLeft setTitle:@"#自拍#" forState:UIControlStateNormal];
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnLeft setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [[_btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
        
    }
    return _btnLeft;
}

- (UIButton *)btnRight{
    if (_btnRight == nil) {
        _btnRight = [[UIButton alloc]init];
        _btnRight.frame = CGRectMake(SCREEN_WIDTH/2, 0,SCREEN_WIDTH/2, 44);
        [_btnRight setTitle:@"#我是段子手#" forState:UIControlStateNormal];
        _btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnRight setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [[_btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
    }
    return _btnRight;
}

- (UIView *)verticalLine{
    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc]init];
        _verticalLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        _verticalLine.frame = CGRectMake(SCREEN_WIDTH/2, 2, 0.5, 40);
        
    }
    return _verticalLine;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;

    }
    return _tableView;
}

- (XFSquareTool *)tool{
    if (_tool == nil) {
        _tool = [[XFSquareTool alloc]init];
    }
    return _tool;
}

@end
