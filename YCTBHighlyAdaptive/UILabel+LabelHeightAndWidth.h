//
//  UILabel+LabelHeightAndWidth.h
//  cell自适应高度
//
//  Created by yishanmen on 16/10/17.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeightAndWidth)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
