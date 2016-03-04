//
//  XFSquareTool.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/4.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFSquareTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "XFSquare.h"

@implementation XFSquareTool

-(void)getSquareData:(void (^)(id))block {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [HttpTool get:BaseURL parameters:params success:^(id json) {
        
        NSArray *squareArray = [XFSquare mj_objectArrayWithKeyValuesArray:json[@"square_list"]];
        block(squareArray);
        
    } failure:^(NSError *error) {
        nil;
    }];
    
}

@end
