//
//  XFCommentViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/1.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFCommentViewController.h"
#import "XFCommentCell.h"
#import "XFModuleDataTool.h"
#import "MJRefresh.h"
#import "XFTopicCell.h"

static NSString *const cellID = @"comment";

@interface XFCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *bottomConstrain;
@property (weak,nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIButton *naviRightBtn;

@property (nonatomic,strong) XFModuleDataTool *tool;
@property (nonatomic,strong) NSMutableArray *hotComments;
@property (nonatomic,strong) NSMutableArray *lastestComments;
@property (nonatomic,assign) NSInteger page;

@end

@implementation XFCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self getNewData];
    [self keyboardChange];
    [self setRefresh];
    [self setupHeader];
    [self setNaviBar];
    [self setTableView];
}


//设置头部的cell
-(void)setupHeader {
    
    UIView *header = [[UIView alloc]init];
    
    XFTopicCell *cell = [XFTopicCell cell];
    cell.topicFrame = self.topicFrame;
    cell.size = CGSizeMake(SCREEN_WIDTH, self.topicFrame.cellHeight);
    
    [header addSubview:cell];
    header.height = self.topicFrame.cellHeight + 10;
    self.tableView.tableHeaderView = header;
    
}

//设置导航
-(void)setNaviBar {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.naviRightBtn];
}

//设置tableView
-(void)setTableView {
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XFCommentCell class]) bundle:nil] forCellReuseIdentifier:cellID];
}

//设置刷新控件
-(void)setRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}


//拿到最新数据
-(void)getNewData {
    
    self.page = 1;
    [self.tool getCommentsWithID:self.topicFrame.topic.ID block:^(NSMutableArray *hotComments, NSMutableArray *lastestComments) {
        self.hotComments = hotComments;
        self.lastestComments = lastestComments;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];     
    }];

    [self.tableView.mj_header endRefreshing];
    
}

//获得更多数据
-(void)getMoreData {
    
    self.page += 1;
    XFCommentModel *comment = [self.lastestComments lastObject];
    [self.tool getCommentsWithID:self.topicFrame.topic.ID page:self.page lastcid:comment.ID block:^(id json,NSInteger total) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (XFCommentModel *comment in json) {
            
            [array addObject:comment];
        }
        [self.lastestComments addObjectsFromArray:array];
        [self.tableView reloadData];
        if (self.lastestComments.count >= total) { // 全部加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    }];

}

//监听键盘的改变
-(void)keyboardChange {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification *noti) {
        //弹出时间
        CGFloat animaDuration = [noti.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        //拿到键盘弹出的frame
        CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        self.bottomConstrain.constant = SCREEN_HEIGHT - frame.origin.y;
        [UIView animateWithDuration:animaDuration animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
}
/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.lastestComments;
    }
    return self.lastestComments;
}

- (XFCommentModel *)commentInIndexPath:(NSIndexPath *)indexPath {
    
    return [self commentsInSection:indexPath.section][indexPath.row];
}

//移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFCommentModel *comment = [self commentInIndexPath:indexPath];
    
    return comment.cellHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建menu菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else {
        //取出点的那一行
        XFCommentCell *cell = (XFCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        //成为第一响应者
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyText:)];
        menu.menuItems = @[ding,replay,report,copy];
        
        CGRect cellRect = CGRectMake(0, cell.height / 2, cell.width, cell.height / 2);
        [menu setTargetRect:cellRect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    //让键盘退出
    [self.view endEditing:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    } else {
        return  @"最新评论";
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.lastestComments.count;
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.lastestComments.count;
    
    if (section == 0) {
            return hotCount ? hotCount : latestCount;
    }
    
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

#pragma mark - MenuItem处理
- (void)ding:(UIMenuController *)menu {//顶
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, indexPath);
}

- (void)replay:(UIMenuController *)menu {//回复
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, indexPath);
}

- (void)report:(UIMenuController *)menu {//举报
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, indexPath);
}

- (void)copyText:(UIMenuController *)menu {//复制
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = [self commentInIndexPath:indexPath].content;
}

#pragma mark - getter and setter 

- (UIButton *)naviRightBtn{
    if (_naviRightBtn == nil) {
        _naviRightBtn = [[UIButton alloc]init];
        [_naviRightBtn setBackgroundImage:[UIImage imageNamed:@"comment_nav_item_share_icon"] forState:UIControlStateNormal];
        [_naviRightBtn setBackgroundImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click"] forState:UIControlStateHighlighted];
        [_naviRightBtn sizeToFit];
    }
    return _naviRightBtn;
}

- (XFModuleDataTool *)tool{
    if (_tool == nil) {
        _tool = [[XFModuleDataTool alloc]init];
        
    }
    return _tool;
}


@end
