//
//  XFTalkViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/21.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTalkViewController.h"
#import "XFTopicCell.h"
#import "XFTalkModel.h"
#import "XFModuleDataTool.h"
#import "MJRefresh.h"


static NSString *const CellID = @"topic";

@interface XFTalkViewController ()
@property (nonatomic,strong) XFModuleDataTool *tool;
@property (nonatomic,strong) NSMutableArray *datas;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要的参数 */
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation XFTalkViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self settableView];
    
    [self setRefresh];
    
    [self getNewData];
    
}

//设置刷新控件
-(void)setRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
                            
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];

}

//获取最新数据
-(void)getNewData {
    self.page = 0;//清空
     @weakify(self)
    [self.tool getTalkDataWithArrayType:TopicTypeTalk block:^(id json, NSString *maxtime) {
        @strongify(self)
            self.datas = json;
            self.maxtime = maxtime;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
    }];
    
}

//获取更多数据
-(void)getMoreData {
    //计算页码
    NSInteger page = self.page+1;
    @weakify(self)
    [self.tool getTalkDataWithMaxtime:self.maxtime page:@(page) TopicType:TopicTypeTalk block:^(id json,NSString *maxtime) {
        @strongify(self)
        [self.datas addObjectsFromArray:json];
        [self.tableView reloadData];
        self.page = page;
        self.maxtime = maxtime;
        [self.tableView.mj_footer endRefreshing];

    }];
    
}


//设置tableView
-(void)settableView{
    self.view.backgroundColor = BackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"XFTopicCell" bundle:nil] forCellReuseIdentifier:CellID];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XFTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    cell.model = self.datas[indexPath.row];
 
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //计算文字高度
    XFTalkModel *model = self.datas[indexPath.row];
    CGFloat cellHeight = model.cellHeight;
    return cellHeight;
}

#pragma mark - getter and setter

- (XFModuleDataTool *)tool{
    if (_tool == nil) {
        _tool = [[XFModuleDataTool alloc]init];
    }
    return _tool;
}


@end
