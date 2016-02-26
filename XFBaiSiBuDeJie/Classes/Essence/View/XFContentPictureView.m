//
//  XFContentPictureView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/23.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFContentPictureView.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"
#import "XFTopicModel.h"
#import "UIImageView+WebCache.h"


@interface XFContentPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *bigPicBtn;
@property (weak, nonatomic) IBOutlet UIImageView *baisiView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progrssView;

@end

@implementation XFContentPictureView

+(instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

-(void)setTopicModel:(XFTopicModel *)topicModel {
    
    [super setTopicModel:topicModel];
    
    [self.progrssView setProgress:0.0 animated:NO];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image2] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.bigPicBtn.hidden = YES;
        self.baisiView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progrssView.hidden = NO;
        self.progrssView.progressLabel.textColor = [UIColor whiteColor];
        self.progrssView.roundedCorners = 3;
        self.progrssView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
        [self.progrssView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progrssView.hidden = YES;
        self.baisiView.hidden = YES;
        
        //判断是不是大图
        if (topicModel.isBigImage) {
            //如果是的话，则截出图片的最上方铺满contentView
            // 开启图形上下文
            UIGraphicsBeginImageContextWithOptions(self.imageView.size, YES, 0.0);
            // 将下载完的image对象绘制到图形上下文
            CGFloat width = self.imageView.width;
            CGFloat height = width * image.size.height / image.size.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            // 获得图片
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 结束图形上下文
            UIGraphicsEndImageContext();
            self.bigPicBtn.hidden = NO;
        } else {
            self.imageView.contentMode = UIViewContentModeScaleToFill;
            self.bigPicBtn.hidden = YES;
        }
    }];
    
    
    self.gifView.hidden = ![topicModel.image2.pathExtension.lowercaseString isEqualToString:@"gif"];
    //self.bigPicBtn.hidden = NO;
 
}

@end
