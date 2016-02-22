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
-(void)getTalkDataWithArray:(void (^)(id json,id param))block;

-(void)getTalkDataWithMaxtime:(NSString *)maxtime page:(NSNumber *)page
                        block:(void (^)(id json,id param))block;

@end
