//
//  XFCommentCell.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/1.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFCommentCell.h"
#import "UIImageView+WebCache.h"
#import "XFUserModel.h"

@interface XFCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *avartar;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation XFCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//使cell一定成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}

//支持的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

-(void)setComment:(XFCommentModel *)comment {
    
    _comment = comment;

    [self.avartar setHeader:comment.user.profile_image];
    self.sex.image = [comment.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    if (comment.voiceuri.length) {
        self.playBtn.hidden = NO;
        [self.playBtn setTitle:[NSString stringWithFormat:@"%ld''", comment.voicetime] forState:UIControlStateNormal];
    } else {

        self.playBtn.hidden = YES;
    }
    self.content.text = comment.content;
    self.name.text = comment.user.username;
    self.like.text = [NSString stringWithFormat:@"%ld", (long)comment.like_count];
    
    CGFloat commentH = [self.content.text boundingRectWithSize:CGSizeMake(204, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    comment.cellHeight = 50 + commentH;
    
    
}



@end
