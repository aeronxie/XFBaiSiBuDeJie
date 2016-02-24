//
//  XFContentPictureView.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/23.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFPictureModel.h"

@interface XFContentPictureView : UIView
+ (instancetype)pictureView;
@property (nonatomic, strong) XFPictureModel *picModel;
@end
