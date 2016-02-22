//
//  XFTalkCell.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTalkCell.h"
#import "UIImageView+WebCache.h"

@interface XFTalkCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *creat_time;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commenBtn;

@property (weak, nonatomic) IBOutlet UITextView *text;
@end

@implementation XFTalkCell



-(void)setModel:(XFTalkModel *)model {
    
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name.text = model.name;
    self.creat_time.text = model.created_at;
    
    [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",model.ding] forState:UIControlStateNormal];
    [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",model.cai] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",model.repost] forState:UIControlStateNormal];
    [self.commenBtn setTitle:[NSString stringWithFormat:@"%ld",model.comment] forState:UIControlStateNormal];
    
    self.text.text = model.text;
    
}

//重新设置尺寸
-(void)setFrame:(CGRect)frame {
    CGFloat inset = 10;
    frame.size.height -= inset;
    frame.origin.y += inset;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    

}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
@end
