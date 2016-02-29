//
//  XFModuleDataTool.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XFModuleDataTool : NSObject
/**
 *  首次刷新（不需要传页码）
 *
 *  @param block 回调
 */
-(void)getDataWithArrayType:(TopicType)type block:(void (^)(id json,id param))block;
/**
 *  加载更多数据（需要传页码）
 *
 *  @param maxtime 参数
 *  @param page    页码
 *  @param block   回调
 */
-(void)getDataWithMaxtime:(NSString *)maxtime page:(NSNumber *)page TopicType:(TopicType)type block:(void (^)(id json,id param))block;

@end
