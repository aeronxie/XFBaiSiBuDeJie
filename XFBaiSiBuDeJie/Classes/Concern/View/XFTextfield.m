//
//  XFTextfield.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/20.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTextfield.h"

@implementation XFTextfield

//成为第一响应者就会调用
-(BOOL)becomeFirstResponder {
    
    [super becomeFirstResponder];
    
    // 修改占位文字颜色
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    return YES;
}

//放弃第一响应者就会调用
-(BOOL)resignFirstResponder {
    
    [super resignFirstResponder];
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

    return YES;
}

@end
