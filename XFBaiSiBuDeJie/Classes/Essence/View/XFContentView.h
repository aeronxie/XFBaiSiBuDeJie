//
//  XFContentView.h
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/24.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTopicModel.h"

@interface XFContentView : UIView
@property (nonatomic,strong) XFTopicModel *topicModel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
