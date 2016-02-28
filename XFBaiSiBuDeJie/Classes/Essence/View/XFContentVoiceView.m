//
//  XFContentVoiceView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/24.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFContentVoiceView.h"
#import "XFDetailPictureController.h"
#import "UIImageView+WebCache.h"


@interface XFContentVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation XFContentVoiceView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

+(instancetype)voiceView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

-(void)showPicture {
    
    XFDetailPictureController *showPicVc = [[XFDetailPictureController alloc]init];
    showPicVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicVc animated:YES completion:nil];
}

-(void)setTopic:(XFTopicModel *)topic {
    
    _topic = topic;
    self.playCount.text = [NSString stringWithFormat:@"%ld播放",(long)topic.playcount];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.middle_image]];
    self.playTime.text = [NSString stringWithFormat:@"%02ld:%02ld", topic.voicetime / 60, topic.voicetime % 60];
    
}

@end
