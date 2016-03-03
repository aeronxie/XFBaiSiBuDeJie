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
#import "XFTopicModel.h"
#import "XFCommentModel.h"
#import "XFLatestViewController.h"


@implementation XFModuleDataTool



-(void)getDataWithArrayType:(TopicType)type parameterA:(NSString *)parameterA block:(void (^)(id json,id param))block {
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = parameterA;
    params[@"c"] = @"data";
    params[@"type"] = @(type);

    [HttpTool get:BaseURL parameters:params success:^(id json) {
        
        NSArray *talekArray = [XFTopicModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
         NSString *maxTime = json[@"info"][@"maxtime"];
        block(talekArray,maxTime);
        
    } failure:^(NSError *error) {
        nil;
    }];
}

-(void)getDataWithMaxtime:(NSString *)maxtime page:(NSNumber *)page TopicType:(TopicType)type parameterA:(NSString *)parameterA block:(void (^)(id json,id param))block {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = parameterA;
    params[@"c"] = @"data";
    params[@"type"] = @(type);
    params[@"page"] = page;
    params[@"maxtime"] = maxtime;

    [HttpTool get:BaseURL parameters:params success:^(id json) {
        
        NSArray *talkMoreArray = [XFTopicModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        
       NSString *maxTime = json[@"info"][@"maxtime"];
        block(talkMoreArray,maxTime);
        
    } failure:^(NSError *error) {
        nil;
    }];
 
}

-(void)getCommentsWithID:(NSString *)ID block:(void (^)(id, id))block {
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = ID;
    params[@"hot"] = @"1";
    [HttpTool get:BaseURL parameters:params success:^(id json) {
       
        // 如果没有数据
        if (![json isKindOfClass:[NSDictionary class]]) {
            return;
        }
        //最热评论
        NSArray *hotCommentArray = [XFCommentModel mj_objectArrayWithKeyValuesArray:json[@"hot"]];
        
        //最新评论
        NSArray *lastestCommentArray = [XFCommentModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        block(hotCommentArray,lastestCommentArray);
        
    } failure:^(NSError *error) {
        nil;
    }];
}


-(void)getCommentsWithID:(NSString *)ID page:(NSInteger)page lastcid:(NSString *)lastcid block:(void (^)(id, NSInteger))block{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = ID;
    params[@"page"] = @(page);
    params[@"lastcid"] = lastcid;
    
    [HttpTool get:BaseURL parameters:params success:^(id json) {
        
        // 如果没有数据没有数据
        if (![json isKindOfClass:[NSDictionary class]]) {
            return;
        }
        //最热评论
        NSArray *moreCommentArray = [XFCommentModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        
        NSInteger total = [json[@"total"] integerValue];
        
        block(moreCommentArray,total);
        
    } failure:^(NSError *error) {
        nil;
    }];

}

@end
