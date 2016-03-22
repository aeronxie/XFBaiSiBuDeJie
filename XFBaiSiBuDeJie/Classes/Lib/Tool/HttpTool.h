//
//  HttpTool.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/18.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
                                                                 failure:(void (^)(NSError *error))failure;

@end
