//
//  XFTalkCell.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTalkModel.h"
#import "XFPictureModel.h"

@interface XFTopicCell : UITableViewCell
@property (nonatomic, strong) XFTalkModel *model;
@property (nonatomic, strong) XFPictureModel *picModel;


@end
