//
//  XFGuideView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/21.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFGuideView.h"

@implementation XFGuideView


+(instancetype)guideView {
    
    return [[[NSBundle mainBundle]loadNibNamed:@"XFGuideView" owner:self options:nil] lastObject];
    
}


- (IBAction)closeBtn:(UIButton *)sender {

    [self removeFromSuperview];

}

@end
