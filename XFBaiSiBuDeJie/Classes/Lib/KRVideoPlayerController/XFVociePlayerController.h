//
//  XFVociePlayerController.h
//  XFBaiSiBuDeJie
//
//  Created by Fay on 16/3/15.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface XFVociePlayerController : UIViewController
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) NSInteger totalTime;
-(void)dismiss;
@end
