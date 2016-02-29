//
//  XFRcommandDataTool.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/18.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFRcommandDataTool : NSObject

/**
 *  获取左边栏数据
 *
 *  @param block 回调
 */
-(void)getCategoryData:(void(^)(id json))block;

/**
 *  获取右边栏数据，用于刷新数据，无需页码参数
 *
 *  @param Id    选中的ID
 *  @param block 回调
 */
-(void)getMainDataWithID:(NSNumber *)Id block:(void (^)(id json))block;

/**
 *  用于右边栏数据用于加载更多
 *
 *  @param Id          选中ID
 *  @param currentPage 当前页码
 *  @param block       回调
 */
-(void)getMainDataWithID:(NSNumber *)Id currentPage:(NSInteger)currentPage block:(void (^)(id json))block;

@end
