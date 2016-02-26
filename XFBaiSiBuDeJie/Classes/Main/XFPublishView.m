//
//  XFPublishView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/25.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFPublishView.h"
#import "XFShowWordBtn.h"

@interface XFPublishView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *slogaTop;

@end
@implementation XFPublishView

+(instancetype)publishView {
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


-(void)awakeFromNib {
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"发链接"];
    
    NSInteger maxCols = 3;
    CGFloat buttonW = 70;
    CGFloat buttonH = 100;
    CGFloat startY = SCREEN_HEIGHT*0.4;
    CGFloat startX = 20;
    CGFloat margin = (SCREEN_WIDTH - 2*startX - maxCols*buttonW) / 2;
    for (NSInteger i = 0; i<images.count; i++) {
        XFShowWordBtn *btn = [XFShowWordBtn buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSInteger row = i / maxCols;//计算行
        NSInteger col = i % maxCols;//计算列
        CGFloat buttonX = startX + col * (buttonW+margin);
        CGFloat buttonY = startY + row * (buttonH + 20);
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self addSubview:btn];
        [self setAnimation:btn];
    }
    
    
}


//设置动画
-(void)setAnimation:(UIView *)button {
    //按钮动画
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
            button.transform = CGAffineTransformMakeScale(0.01,0.01);;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                button.transform = CGAffineTransformMakeScale(1,1);
                
            } completion:^(BOOL finished) {
                //标语动画
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                    self.slogaTop.constant = 120;
                    [self layoutIfNeeded];
                } completion:nil];
                
            }];
        }];
    }];
}

//取消时的动画
- (void)cancelAnimation{
    
    for (NSInteger i = 0; i<self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[XFShowWordBtn class]]) {
            [UIView animateWithDuration:0.3 delay:0.05*i options:UIViewAnimationOptionTransitionCurlDown animations:^{
                view.y = 1000;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
        [UIView animateWithDuration:0.7 animations:^{
            self.slogaTop.constant = 800;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        
        }];
}

//取消按钮
- (IBAction)cancelBtn:(UIButton *)sender {
    
    [self cancelAnimation];
    
}

@end
