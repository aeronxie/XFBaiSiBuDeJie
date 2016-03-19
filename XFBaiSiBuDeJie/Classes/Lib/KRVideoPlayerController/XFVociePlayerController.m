//
//  XFVociePlayerController.m
//  XFBaiSiBuDeJie
//
//  Created by Fay on 16/3/15.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFVociePlayerController.h"
#import "NSString+XFTime.h"

@interface XFVociePlayerController ()

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *restTime;
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UISlider *progress;
//播放器
@property (nonatomic,strong)MPMoviePlayerController *player;
/** 进度的Timer */
@property (nonatomic, strong) NSTimer *progressTimer;
//slider 事件处理
- (IBAction)startSlide;
- (IBAction)sliderValueChange;
- (IBAction)endSlide;
- (IBAction)sliderClick:(UITapGestureRecognizer *)sender;
//暂停
- (IBAction)pause;
@end


@implementation XFVociePlayerController


-(void)viewDidLoad {
    [self.progress setThumbImage:[UIImage imageNamed:@"kr-video-player-point"] forState:UIControlStateNormal];
    [self startPlayingMusic];
    self.playTime.text = [NSString stringWithTime:self.totalTime];
     _player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.url]];
    [self.player play];
    
}

//开始播放音乐
- (void)startPlayingMusic {
    
    [self removeProgressTimer];
    [self addProgressTimer];

}

//添加定时器
- (void)addProgressTimer
{
    [self updateProgressInfo];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - 更新进度的界面
- (void)updateProgressInfo
{
    // 1.设置当前的播放时间
    self.restTime.text = [NSString stringWithTime:self.player.currentPlaybackTime];
    
    // 2.更新滑块的位置
    self.progress.value = self.player.currentPlaybackTime / self.player.duration;
}

#pragma mark - Slider的事件处理
- (IBAction)startSlide {
    [self removeProgressTimer];
}

- (IBAction)sliderValueChange {
    // 设置当前播放的时间Label
    self.restTime.text = [NSString stringWithTime:self.player.duration * self.progress.value];
}

- (IBAction)endSlide {
    // 1.设置歌曲的播放时间
    self.player.currentPlaybackTime = self.progress.value * self.player.duration;
    
    // 2.添加定时器
    [self addProgressTimer];
}

- (IBAction)sliderClick:(UITapGestureRecognizer *)sender {
    // 1.获取点击的位置
    CGPoint point = [sender locationInView:sender.view];
    
    // 2.获取点击的在slider长度中占据的比例
    CGFloat ratio = point.x / self.progress.bounds.size.width;
    
    // 3.改变歌曲播放的时间
    self.player.currentPlaybackTime = ratio * self.player.duration;
    
    // 4.更新进度信息
    [self updateProgressInfo];
}
//暂停
- (IBAction)pause {
    self.playBtn.selected = !self.playBtn.selected;
    
    if (self.playBtn.selected) {
        [self.player pause];
        
        [self removeProgressTimer];
        
        } else {
        [self.player play];
        
        [self addProgressTimer];
            
    }
}

//移除定时器
- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

-(void)dismiss {
    [self removeProgressTimer];
    [self.player stop];
}

@end
