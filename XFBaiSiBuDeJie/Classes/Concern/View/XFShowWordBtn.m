//
//  XFShowWordBtn.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/20.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFShowWordBtn.h"

@implementation XFShowWordBtn



- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
    
}

@end
