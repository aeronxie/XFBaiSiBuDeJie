//
//  XFRcommandDataTool.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/18.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFRcommandDataTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "XFCategoryModel.h"
#import "XFMainTableModel.h"
#import "SVProgressHUD.h"


static NSString *const categoryUrl = @"http://api.budejie.com/api/api_open.php";
@implementation XFRcommandDataTool

-(void)getCategoryData:(void (^)(id))block {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [HttpTool get:categoryUrl parameters:parameters success:^(id json) {
        NSArray *listArray = [XFCategoryModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        block(listArray);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
        nil;
    }];
    
}

-(void)getMainDataWithID:(NSNumber *)Id block:(void (^)(id json))block {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = Id;
    
    [HttpTool get:categoryUrl parameters:parameters success:^(id json) {
        
        NSMutableArray *mainArray = [XFMainTableModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        block(mainArray);
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
        nil;
    }];

}


-(void)getMainDataWithID:(NSNumber *)Id currentPage:(NSInteger)currentPage block:(void (^)(id))block {
     
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = Id;
    parameters[@"page"] = @(currentPage);
    [HttpTool get:categoryUrl parameters:parameters success:^(id json) {
     
        NSMutableArray *mainArray = [XFMainTableModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
        block(mainArray);

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
        nil;
    }];
    
    
    
    
}
@end
