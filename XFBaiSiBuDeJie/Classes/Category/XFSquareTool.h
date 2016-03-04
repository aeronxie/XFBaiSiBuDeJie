//
//  XFSquareTool.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/4.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFSquareTool : NSObject

/**
 *  回去广场方块数据
 *
 *  @param block 回调
 */
-(void)getSquareData:(void(^)(id json))block;

@end
