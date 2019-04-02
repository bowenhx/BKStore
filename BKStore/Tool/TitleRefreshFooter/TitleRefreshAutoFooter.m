/**
 -  TitleRefreshAutoFooter.h
 -  TWBK
 -  Created by calvin_tse on 2017/5/21.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是不会回弹到底部的自定义上拉刷新控件.为TWBK2.1添加.适用于上拉刷新后,新数据直接拼接到下面的情况
 */

#import "TitleRefreshAutoFooter.h"

@interface TitleRefreshAutoFooter ()
/**
 文字label
 */
@property (nonatomic, weak) UILabel *titleLabel;
/**
 左边的横线视图
 */
@property (nonatomic, weak) UIView *leftView;
/**
 右边的黑线视图
 */
@property (nonatomic, weak) UIView *rightView;
@end

@implementation TitleRefreshAutoFooter
#pragma mark 在这里添加子控件
- (void)prepare {
    [super prepare];
    
    // 设置本控件的高度
    self.mj_h = 50;
    
    // 添加文字label
    UILabel *titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor lightGrayColor];
    
    
    // 添加左侧的黑线
    UIView *leftView = [UIView new];
    [self addSubview:leftView];
    self.leftView = leftView;
    leftView.backgroundColor = [UIColor lightGrayColor];
    leftView.hidden = YES;
    
    // 添加右侧的黑线
    UIView *rightView = [UIView new];
    [self addSubview:rightView];
    self.rightView = rightView;
    rightView.backgroundColor = [UIColor lightGrayColor];
    rightView.hidden = YES;
}


#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    
    // 先获取到当前控件的宽度&高度
    CGFloat width = self.mj_w;
    CGFloat height = self.mj_h;
    // 定义两个黑线的水平偏移距离
    CGFloat offsetX = 90;
    
    // 设置文字label的位置和尺寸
    self.titleLabel.frame = CGRectMake(0, 0, width, height);
    self.titleLabel.center = CGPointMake(width / 2, height / 2);
    
    // 设置左侧黑线的位置和尺寸
    self.leftView.frame = CGRectMake(0, 0, self.mj_w / 8, 1);
    self.leftView.center = CGPointMake(width / 2 - offsetX, height / 2);
    
    // 设置右侧黑线的位置和尺寸
    self.rightView.frame = CGRectMake(0, 0, self.mj_w / 8, 1);
    self.rightView.center = CGPointMake(width / 2 + offsetX, height / 2);
}


#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateNoMoreData: {
            // 没有更多数据的状态
            self.titleLabel.text = @"已無更多內容";
            [self hideTwoBlackLineView:NO];
            break;
        }
        case MJRefreshStateRefreshing: {
            // 正在刷新中的状态
            self.titleLabel.text = @"正在努力加載...";
            [self hideTwoBlackLineView:YES];
            break;
        }
        default: {
            // 其他状态
            self.titleLabel.text = nil;
            [self hideTwoBlackLineView:YES];
        }
    }
}

/**
 内部使用的自定义方法,用来显示或者隐藏两根黑色的线条
 
 @param isHide YES为隐藏,NO为不隐藏
 */
- (void)hideTwoBlackLineView:(BOOL)isHide {
    self.leftView.hidden = isHide;
    self.rightView.hidden = isHide;
}

@end
