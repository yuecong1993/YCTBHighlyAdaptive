//
//  YCTableViewCell.h
//  cell自适应高度
//
//  Created by yishanmen on 16/7/26.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCTableViewCell : UITableViewCell

//用户名
@property(nonatomic,retain) UILabel *name;
//用户介绍
@property(nonatomic,retain) UILabel *introduction;
//用户头像
@property(nonatomic,retain) UIImageView *userImage;

@property(nonatomic,strong) UIView *lineView;

@property(nonatomic,strong) UILabel *labelText;



//给用户介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
