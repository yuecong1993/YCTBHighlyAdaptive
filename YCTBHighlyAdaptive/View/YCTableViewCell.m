//
//  YCTableViewCell.m
//  cell自适应高度
//
//  Created by yishanmen on 16/7/26.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import "YCTableViewCell.h"
#import "UILabel+LabelHeightAndWidth.h"


@implementation YCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}
//初始化控件
-(void)initLayuot{
    _name = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 250, 100)];
    [self addSubview:_name];
    
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 100, 100)];
    [self addSubview:_userImage];

    
    _introduction = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 250, 80)];
    _introduction.backgroundColor = [UIColor clearColor];
    _introduction.font = [UIFont systemFontOfSize:14];
    _introduction.numberOfLines = 0;
    _introduction.textColor = [UIColor grayColor];
    [self addSubview:_introduction];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 10,[UIScreen mainScreen].bounds.size.width - 10, 100)];
    _lineView.backgroundColor = [UIColor blueColor];
    [self addSubview:_lineView];
    
    _labelText = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 10)];
    _labelText.textColor = [UIColor purpleColor];
    _labelText.text = @"传世经典";
    [self addSubview:_labelText];
}

//赋值计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //文本赋值
    self.introduction.text = text;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UILabel getHeightByWidth:width title:self.introduction.text font:self.introduction.font];
    self.introduction.frame = CGRectMake(10, 120, width - 20, height);
    
    _labelText.frame = CGRectMake(10, CGRectGetMaxY(self.introduction.frame) +5, 200, 20);

    self.frame = CGRectMake(0,0, 0, height + 25 + 125);
    
    _lineView.frame = CGRectMake(10,  self.frame.size.height - 1, width - 10, 1);

}

@end
