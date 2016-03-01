//
//  XFTalkCell.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTopicFrame.h"

@protocol XFTopicCellDelegate <NSObject>

@optional

-(void)commentBtnClick;

@end
@interface XFTopicCell : UITableViewCell
@property (nonatomic, strong) XFTopicFrame *topicFrame;
@property (nonatomic, weak) id<XFTopicCellDelegate> delegate;
+ (instancetype)cell;
@end
