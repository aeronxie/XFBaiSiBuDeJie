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


@interface XFContentPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *bigPicBtn;
@property (weak, nonatomic) IBOutlet UIImageView *contentPicture;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progrssView;

@end

@implementation XFContentPictureView

+(instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"XFContentPictureView" owner:nil options:nil] lastObject];
    
}


-(void)setPicModel:(XFPictureModel *)picModel {
    
    _picModel = picModel;
    
    [self.contentPicture sd_setImageWithURL:[NSURL URLWithString:picModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progrss = 1.0*receivedSize / expectedSize;
        [self.progrssView setProgress:progrss animated:YES];
        self.progrssView.progressLabel.text = [NSString stringWithFormat:@"%f%%",progrss*100.0];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progrssView.hidden = YES;
    }];
    
    // 判断是否为gif
    NSString *extension = picModel.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (picModel.isBigPicture) { // 大图
        self.bigPicBtn.hidden = NO;
    } else { // 非大图
        self.bigPicBtn.hidden = YES;
    }

    
}


@end
