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
#import "XFUserModel.h"
#import "XFCommentViewController.h"

@interface XFTopicCell ()

@property (weak,nonatomic) IBOutlet UIImageView *avatar;
@property (weak,nonatomic) IBOutlet UILabel *name;
@property (weak,nonatomic) IBOutlet UILabel *creat_time;
@property (weak,nonatomic) IBOutlet UIButton *dingBtn;
@property (weak,nonatomic) IBOutlet UIButton *caiBtn;
@property (weak,nonatomic) IBOutlet UIButton *shareBtn;
@property (weak,nonatomic) IBOutlet UIButton *commenBtn;
@property (weak,nonatomic) IBOutlet UILabel *text;
@property (weak,nonatomic) IBOutlet UILabel *topCmtContentText;
@property (weak,nonatomic) IBOutlet UIView *topCmtView;

@property (strong,nonatomic) XFContentPictureView *pictureView;
@property (strong,nonatomic) XFContentVideoView *videoView;
@property (strong,nonatomic) XFContentVoiceView *voiceView;
@end

@implementation XFTopicCell

// 从队列里面复用时调用
- (void)prepareForReuse {
    
    [super prepareForReuse];
    [_videoView reset];
    [_voiceView reset];
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


-(void)setTopicFrame:(XFTopicFrame *)topicFrame {
    
    _topicFrame = topicFrame;
    XFTopicModel *topic = topicFrame.topic;
    
    [self.avatar setHeader:topic.profile_image];
        self.name.text = topic.name;
        self.creat_time.text = topic.created_at;
        self.text.text = topic.text;
    
        [self.dingBtn setTitle:[NSString stringWithFormat:@"%ld",topic.ding] forState:UIControlStateNormal];
        [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",topic.cai] forState:UIControlStateNormal];
        [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",topic.repost] forState:UIControlStateNormal];
        [self.commenBtn setTitle:[NSString stringWithFormat:@"%ld",topic.comment] forState:UIControlStateNormal];
    
    // 处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentText.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }

    
   if (topic.type == TopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame  = topicFrame.contentViewFrame;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == TopicTypeVideo) {
        self.videoView.topic = topic;
        self.videoView.frame  = topicFrame.contentViewFrame;
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == TopicTypeVoice) {
        self.voiceView.topic = topic;
        self.voiceView.frame  = topicFrame.contentViewFrame;
        self.voiceView.hidden = NO;
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    

}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}

//更多按钮
- (IBAction)moreBtn:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil];
    
     [alertController addAction:report];
     [alertController addAction:cancel];
     [alertController addAction:save];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

//评论按钮
- (IBAction)commentBtn:(UIButton *)sender {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topicFrame forKey:@"topicFrame"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"commentClick" object:nil userInfo:dic];
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:@"topicFrame"];
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
