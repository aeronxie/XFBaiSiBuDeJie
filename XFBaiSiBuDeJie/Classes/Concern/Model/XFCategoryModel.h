//
//  XFCategoryModel.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/18.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFCategoryModel : NSObject
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger count;


/** 用于缓存下载下来的对应类别数据 */
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger currentPage;
@end
