//
//  XFMainTableModel.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/19.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFMainTableModel : NSObject
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, assign) NSInteger tiezi_count;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, assign,getter=isVip)  BOOL is_vip;


/** 用于存放右边表格下载好的数据 */
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger currentPage;
@end
