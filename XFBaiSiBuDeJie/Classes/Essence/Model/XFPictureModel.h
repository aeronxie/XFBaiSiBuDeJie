//
//  XFPictureModel.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/23.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPictureModel : NSObject
/** 昵称 */
@property (nonatomic,copy) NSString *name;
/** 头像 */
@property (nonatomic,copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic,copy) NSString *created_at;
/** 文字内容 */
@property (nonatomic,copy) NSString *text;
/** 顶的数量 */
@property (nonatomic,assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic,assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic,assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic,assign) NSInteger comment;
/** 小图片 */
@property (nonatomic,copy) NSString *small_image;
/** 中图片 */
@property (nonatomic,copy) NSString *middle_image;
/** 大图片 */
@property (nonatomic,copy) NSString *large_image;


/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;
/** 图片容器的frame */
@property (nonatomic,assign,readonly) CGRect pictureFrame;
/** 图片是否太大 */
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;
@end
