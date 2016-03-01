//
//  XFRecommendViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/18.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFRecommendViewController.h"
#import "XFRcommandDataTool.h"
#import "XFCategoryModel.h"
#import "XFCategoryCell.h"
#import "XFMainTableCell.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"


static NSString *const categoryID = @"category";
static NSString *const mainID = @"main";

@interface XFRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *categoryTable;
@property (nonatomic,weak) IBOutlet UITableView *mainTable;
@property (nonatomic,strong) XFRcommandDataTool *tool;
@property (nonatomic,strong) NSArray *categoryArray;
@property (nonatomic,strong) NSMutableArray *mainTableArray;
@property (nonatomic,assign) NSInteger page;

@end

@implementation XFRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = BackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupTableView];
    
    [self setupRefreshView];

    //获得侧边数据
    [self.tool getCategoryData:^(id json) {
        self.categoryArray = json;
        [self.categoryTable reloadData];
    }];
    

}

//设置tableView
-(void)setupTableView {
    self.categoryTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.mainTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.mainTable.rowHeight = 70;
    self.categoryTable.backgroundColor = BackgroundColor;
    //去掉不要的cell
    self.categoryTable.tableFooterView = [[UIView alloc]init];
    //注册tableView
    [self.categoryTable registerNib:[UINib nibWithNibName:@"XFCategoryCell" bundle:nil] forCellReuseIdentifier:categoryID];
    [self.mainTable registerNib:[UINib nibWithNibName:@"XFMainTableCell" bundle:nil] forCellReuseIdentifier:mainID];

}

-(void)setupRefreshView {
    
    self.mainTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
     [self.mainTable.mj_header beginRefreshing];
    self.mainTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.mainTable.mj_footer.hidden = YES;

}

//加载最新数据
-(void)loadNew {
    self.page = 1;
    [self.mainTableArray removeAllObjects];
    XFCategoryModel *model = self.categoryArray[self.categoryTable. indexPathForSelectedRow.row];
    [self.tool getMainDataWithID:@(model.id) block:^(id json) {
        self.mainTableArray = json;
        model.users = json;
        [self.mainTable reloadData];
        [self.mainTable.mj_header endRefreshing];
    }];
    
}

//加载更多数据
-(void)loadMore {
    self.page += 1;
    XFCategoryModel *model = self.categoryArray[self.categoryTable. indexPathForSelectedRow.row];
    [self.tool getMainDataWithID:@(model.id) currentPage:self.page block:^(id json) {
        [self.mainTableArray addObjectsFromArray:json];
        [self.mainTable reloadData];
        [self.mainTable.mj_footer endRefreshing];
    }];
 
}

#pragma mark  - UITableViewDelegate 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.mainTable.mj_header beginRefreshing];

    XFCategoryModel *model = self.categoryArray[indexPath.row];
    [self.tool getMainDataWithID:@(model.id) block:^(id json) {
            self.mainTableArray = json;
            [self.mainTable reloadData];
            [self.mainTable.mj_header endRefreshing];
    }];
}



#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTable) {

        return self.categoryArray.count;
    }
    
    return self.mainTableArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (tableView == self.categoryTable) {
        XFCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.model = self.categoryArray[indexPath.row];
        [self.categoryTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        return cell;
    } else {
        XFMainTableCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
        cell.model = self.mainTableArray[indexPath.row];
        return cell;
    }
}

#pragma mark - getter and setter

- (XFRcommandDataTool *)tool{
    if (_tool == nil) {
        _tool = [[XFRcommandDataTool alloc]init];
        
    }
    return _tool;
}



@end
