//
//  XFCommentModel.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/29.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFUserModel;
@interface XFCommentModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) XFUserModel *user;
/** 有声音时的行高 */
@property (nonatomic,assign) CGFloat cellHeight;

@end

