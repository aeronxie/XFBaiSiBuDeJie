//
//  XFTopicModel.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/22.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFCommentModel.h"

@interface XFTopicModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *created_at;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
//内容类型
@property (nonatomic, assign) TopicType type;
/** 最热评论(数组放的是Comment模型) */
@property (nonatomic, strong) XFCommentModel *top_cmt;

/** 小图片*/
@property (nonatomic, copy) NSString *small_image;
/** 中图片*/
@property (nonatomic, copy) NSString *middle_image;
/** 大图片 */
@property (nonatomic, copy) NSString *large_image;

/** 是否为gif图片 */
@property (assign, nonatomic) BOOL is_gif;
/** 视频或图片类型帖子的宽度 */
@property (assign, nonatomic) CGFloat width;
/** 视频或图片类型帖子的高度 */
@property (assign, nonatomic) CGFloat height;


/** 音频的时长 */
@property (assign, nonatomic) NSInteger voicetime;
/** 播放次数 */
@property (assign, nonatomic) NSInteger playcount;
/** 音频的播放地址 */
@property (copy, nonatomic) NSString *voiceuri;


/** 视频的播放地址 */
@property (copy, nonatomic) NSString *videouri;
/** 视频的时长 */
@property (assign, nonatomic) NSInteger videotime;

/****** 是否为大图 ******/
@property (assign, nonatomic, getter=isBigImage) BOOL bigImage;



@end
