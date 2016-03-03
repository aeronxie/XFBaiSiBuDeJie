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
-(void)getDataWithArrayType:(TopicType)type parameterA:(NSString *)parameterA block:(void (^)(id json,id param))block;
/**
 *  加载更多数据（需要传页码）
 *
 *  @param maxtime 参数
 *  @param page    页码
 *  @param block   回调
 */
-(void)getDataWithMaxtime:(NSString *)maxtime page:(NSNumber *)page TopicType:(TopicType)type parameterA:(NSString *)parameterA block:(void (^)(id json,id param))block;

/**
 *  加载最新的评论（最热和最新评论）
 *
 *  @param ID    ID
 *  @param block 回调
 */
-(void)getCommentsWithID:(NSString *)ID block:(void (^)(id json1,id json2))block;

/**
 *  加载更多最新评论
 *
 *  @param ID      ID
 *  @param page    页码
 *  @param lastcid 上次id
 *  @param block   回调
 */
-(void)getCommentsWithID:(NSString *)ID page:(NSInteger)page lastcid:(NSString *)lastcid block:(void (^)(id json,NSInteger total))block;

@end
