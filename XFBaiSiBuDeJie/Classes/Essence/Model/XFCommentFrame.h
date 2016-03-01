//
//  XFCommentFrame.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/1.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFCommentModel.h"

@interface XFCommentFrame : NSObject
@property (nonatomic,strong)XFCommentModel *comment;
@property (assign, nonatomic) CGFloat cellHeight;
@end
