//
//  XFSquare.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/4.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFSquare : NSObject
/** id */
@property (nonatomic, copy) NSString *id;
/** 图片 */
@property (nonatomic, copy) NSString *icon;
/** 标题文字 */
@property (nonatomic, copy) NSString *name;
/** 链接 */
@property (nonatomic, copy) NSString *url;
/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
