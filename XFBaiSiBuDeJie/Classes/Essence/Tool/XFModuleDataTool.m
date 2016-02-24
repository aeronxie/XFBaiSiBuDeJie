//
//  XFModuleDataTool.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFModuleDataTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "XFTalkModel.h"


@implementation XFModuleDataTool
-(void)getTalkDataWithArrayType:(TopicType)type block:(void (^)(id json,id param))block {
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(type);

    [HttpTool get:BaseURL parameters:params success:^(id json) {
        
        NSArray *talekArray = [XFTalkModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
         NSString *maxTime = json[@"info"][@"maxtime"];
        block(talekArray,maxTime);
        
    } failure:^(NSError *error) {
        nil;
    }];
}

-(void)getTalkDataWithMaxtime:(NSString *)maxtime page:(NSNumber *)page TopicType:(TopicType)type block:(void (^)(id json,id param))block {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = page;
    params[@"maxtime"] = maxtime;

    [HttpTool get:BaseURL parameters:params success:^(id json) {
        
        NSArray *talkMoreArray = [XFTalkModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        
       NSString *maxTime = json[@"info"][@"maxtime"];
        block(talkMoreArray,maxTime);
        
    } failure:^(NSError *error) {
        nil;
    }];
    
    
    
}

@end
