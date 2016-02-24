//
//  XFTalkModel.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTalkModel.h"

static CGFloat avatarMaxY = 50;
static CGFloat inset = 10;
static CGFloat toolBarHeight = 50;

@implementation XFTalkModel

-(CGFloat)cellHeight {
    
    if (!_cellHeight) {
        CGFloat textHeight = [self.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 28 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = avatarMaxY + inset * 2 + toolBarHeight + textHeight ;
        
    }
    return _cellHeight;
}

@end
