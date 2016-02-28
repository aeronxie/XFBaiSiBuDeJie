//
//  XFContentPictureView.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/23.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFTopicModel;
@interface XFContentPictureView : UIView
@property (nonatomic,strong) XFTopicModel *topic;
+ (instancetype)pictureView;

@end
