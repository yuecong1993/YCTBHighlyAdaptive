//
//  YCChartView.h
//  cell自适应高度
//
//  Created by yishanmen on 16/10/8.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCChartView;

@protocol YCChatrDelegate <NSObject>

- (void)ycChartView:(YCChartView *)pieView didSelectSectionAtIndex:(NSInteger)index;

@end

@interface YCChartModel : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, copy) NSString *text;

- (instancetype)initWithColor:(UIColor *)color value:(CGFloat)value text:(NSString *)text;

@end

@interface YCChartView : UIView

@property (nonatomic, weak) id<YCChatrDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame values:(NSArray<YCChartModel *> *)valueArray;

- (void)reloadData;


@end
