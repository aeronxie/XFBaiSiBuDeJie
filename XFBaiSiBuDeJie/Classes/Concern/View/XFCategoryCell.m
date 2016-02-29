//
//  XFCategoryCell.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/19.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFCategoryCell.h"

@interface XFCategoryCell ()

@end
@implementation XFCategoryCell

- (void)awakeFromNib {
    // Initialization code
   
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor grayColor];
    UIView *selectedView = [[UIView alloc]initWithFrame:self.frame];
    UIView *selectedIndicator = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.height+1)];
    selectedIndicator.backgroundColor = GLOBALCOLOR(219, 21, 26,1);
    [selectedView addSubview:selectedIndicator];
    self.selectedBackgroundView = selectedView;
    self.selectedBackgroundView.backgroundColor = GLOBALCOLOR(245, 245, 245, 1);;
    
    self.textLabel.highlightedTextColor = GLOBALCOLOR(219, 21, 26,1);
}

-(void)setModel:(XFCategoryModel *)model {
    
    _model = model;
    self.textLabel.text = model.name;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
