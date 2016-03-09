//
//  XFSquareFooterView.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/3/4.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFSquareFooterView.h"
#import "XFSquareTool.h"
#import "XFSquareButton.h"
#import "XFWebviewController.h"

@implementation XFSquareFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createItems];
    }
    return self;
}

//创建按钮
-(void)createItems {
    
    //一共4列
    NSInteger maxCols = 4;
    CGFloat btnW = SCREEN_WIDTH / 4;
    CGFloat btnH = btnW;
    XFSquareTool *tool = [[XFSquareTool alloc]init];
    NSLog(@"1");
    [tool getSquareData:^(NSArray *squareItems) {
        
        for (NSInteger i = 0; i < squareItems.count; i++) {
            XFSquareButton *button = [[XFSquareButton alloc]init];
            button.square = squareItems[i];
            NSInteger col = i % maxCols;//第几列
            NSInteger row = i / maxCols;//第几行
            CGFloat btnX = col * btnW;
            CGFloat btnY = row * btnH;
            button.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [self addSubview:button];
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(XFSquareButton *button) {
                if (![button.square.url hasPrefix:@"http"]) return;
                XFWebviewController *web = [[XFWebviewController alloc]init];
                web.url = button.square.url;
                web.title = button.square.name;
                // 取出当前的导航控制器
                UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
                [nav pushViewController:web animated:YES];
            }];
        }
        //算出footer的高度
        self.height = (squareItems.count + maxCols - 1)/maxCols *  btnH;
        [self setNeedsDisplay];
    }];
}

@end
