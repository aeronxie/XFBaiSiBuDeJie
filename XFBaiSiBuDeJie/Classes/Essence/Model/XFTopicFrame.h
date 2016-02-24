//
//  XFTopicFrame.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/24.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFTopicModel.h"

@interface XFTopicFrame : NSObject
@property (nonatomic,strong)XFTopicModel *topic;
@property (assign, nonatomic) CGFloat cellHeight;
@property (assign, nonatomic) CGRect  contentViewFrame;//图片或视频或声音内容尺寸
@end
