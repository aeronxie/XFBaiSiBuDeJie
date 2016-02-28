//
//  XFTalkCell.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTopicCell.h"
#import "UIImageView+WebCache.h"
#import "XFContentPictureView.h"
#import "XFContentVideoView.h"
#import "XFContentVoiceView.h"

@interface XFTopicCell ()

@property (weak,nonatomic) IBOutlet UIImageView *avatar;
@property (weak,nonatomic) IBOutlet UILabel *name;
@property (weak,nonatomic) IBOutlet UILabel *creat_time;
@property (weak,nonatomic) IBOutlet UIButton *dingBtn;
@property (weak,nonatomic) IBOutlet UIButton *caiBtn;
@property (weak,nonatomic) IBOutlet UIButton *shareBtn;
@property (weak,nonatomic) IBOutlet UIButton *commenBtn;
@property (weak,nonatomic) IBOutlet UILabel *text;
@property (strong,nonatomic) XFContentPictureView *pictureView;
@property (strong,nonatomic) XFContentVideoView *videoView;
@property (strong,nonatomic) XFContentVoiceView *voiceView;
@end

@implementation XFTopicCell


-(void)setTopicFrame:(XFTopicFrame *)topicFrame {
    
    _topicFrame = topicFrame;
    XFTopicModel *topic = topicFrame.topic;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        self.name.text = topic.name;
        self.creat_time.text = topic.created_at;
        self.text.text = topic.text;
    
        [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",topic.ding] forState:UIControlStateNormal];
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",topic.cai] forState:UIControlStateNormal];
        [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",topic.repost] forState:UIControlStateNormal];
        [self.commenBtn setTitle:[NSString stringWithFormat:@"%ld",topic.comment] forState:UIControlStateNormal];
    
    
    if (topic.type == TopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame  = topicFrame.contentViewFrame;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == TopicTypeVideo) {
        self.videoView.topic = topic;
        self.videoView.frame  = topicFrame.contentViewFrame;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == TopicTypeVoice) {
        self.voiceView.topic = topic;
        self.voiceView.frame  = topicFrame.contentViewFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
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


#pragma mark - getter and setter
- (XFContentPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [XFContentPictureView pictureView];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

-(XFContentVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [XFContentVideoView videoView];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (XFContentVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [XFContentVoiceView voiceView];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

@end
