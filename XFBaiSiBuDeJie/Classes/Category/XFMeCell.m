//
//  XFMeCell.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/3.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFMeCell.h"

@interface XFMeCell ()
@end
@implementation XFMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];

    }
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    self.imageView.width = 26;
    self.imageView.height = 26;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;

}

@end
