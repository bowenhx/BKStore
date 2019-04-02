/**
 -  ZoomRefreshHeader.m
 -  TWBK
 -  Created by calvin_tse on 2017/5/3.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:该头部刷新控件为TWBK v2.1.0.添加.
 -  继承自MJRefreshHeader,对三种状态的UI进行了自定义
 -  "爸妈图书馆"&"每日任务"模块的tableView有组头,所以为了减小头部控件距离tableView的距离,添加了一个contentOffsetY属性用来设置内部控件的垂直偏移值
 */

#import "ZoomRefreshHeader.h"
#import "MJRefresh.h"
#import "DefineFile.h"

@interface ZoomRefreshHeader ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label;
/**
 用来记录imageView的frame
 */
@property (nonatomic, assign) CGRect imageViewRect;
/**
 当前控件自身的高度
 */
@property (nonatomic, assign) CGFloat selfHeight;
/**
 保存各个状态下对应的文字的字典
 */
@property (nonatomic, strong) NSMutableDictionary *stateTitleDictionary;
@end

@implementation ZoomRefreshHeader

#pragma mark 在这里添加子控件
- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = self.selfHeight;
    
    // 添加label
    UILabel *label = [UILabel new];
    self.label = label;
    [self addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    
    // 添加imageView
    UIImageView *imageView = [UIImageView new];
    self.imageView = imageView;
    [self addSubview:imageView];
}


#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    
    // 设置两个子控件的尺寸
    CGFloat labelHeight = 20;
    CGFloat labelWidth = 100;
    CGFloat labelY = self.selfHeight / 2 - labelHeight / 2 + self.contentOffsetY;
    CGFloat labelX = SCREEN_WIDTH / 2;
    self.label.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    self.imageView.frame = self.imageViewRect;
}


#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    // 限制系数最大为1
    if (pullingPercent > 1) {
        pullingPercent = 1;
    }
    
    // 设置图片尺寸
    CGFloat imageViewHeight = self.selfHeight * pullingPercent;
    CGFloat imageViewWidth = imageViewHeight / 7 * 8;
    CGFloat imageViewX = (SCREEN_WIDTH - self.selfHeight - imageViewWidth) / 2;
    CGFloat imageViewY = self.contentOffsetY;
    
    // 更新图片尺寸
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    self.imageViewRect = self.imageView.frame;
}


#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    // 下拉时的2幅图片
    NSArray *idleImageArray = @[
                                [UIImage imageNamed:@"top_loading_1"],
                                [UIImage imageNamed:@"top_loading_2"]
                               ];
    
    // 正在刷新时的4副图片
    NSMutableArray *refreshingImageArray = [NSMutableArray array];
    for (int i = 3; i <= 7; i++) {
        NSString *imageName = [NSString stringWithFormat:@"top_loading_%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [refreshingImageArray addObject:image];
    }
    
    // 根据控件状态,修改UI效果
    switch (state) {
        case MJRefreshStateIdle: {
            // 如果外部设置了普通闲置状态下显示的文字信息的话,则显示外部传入的文字
            // 否则,显示默认文字"下拉更新..."
            // 其余的情况下同理
            if (self.stateTitleDictionary[@(MJRefreshStateIdle)]) {
                self.label.text = self.stateTitleDictionary[@(MJRefreshStateIdle)];
            } else {
                self.label.text = @"下拉更新...";
            }
            self.imageView.animationImages = idleImageArray;
            self.imageView.animationDuration = 0.75f;
            [self.imageView startAnimating];
            break;
        }
        case MJRefreshStatePulling: {
            if (self.stateTitleDictionary[@(MJRefreshStatePulling)]) {
                self.label.text = self.stateTitleDictionary[@(MJRefreshStatePulling)];
            } else {
                self.label.text = @"鬆手刷新...";
            }
            [self.imageView stopAnimating];
            self.imageView.image = [UIImage imageNamed:@"top_loading_2"];
            break;
        }
        case MJRefreshStateRefreshing: {
            if (self.stateTitleDictionary[@(MJRefreshStateRefreshing)]) {
                self.label.text = self.stateTitleDictionary[@(MJRefreshStateRefreshing)];
            } else {
                self.label.text = @"努力加載中...";
            }
            self.imageView.animationImages = refreshingImageArray;
            self.imageView.animationDuration = 0.75f;
            [self.imageView startAnimating];
            break;
        }
        default:
            break;
    }
}


/**
 返回控件自身的高度

 @return 控件自身的高度
 */
- (CGFloat)selfHeight {
    return 80;
}


#pragma mark - 供外界使用的方法,当外界需要设置不同状态下的文字的时候,使用该方法
/**
 设置控件不同状态下的文字信息
 
 @param title 文字信息
 @param state 控件的状态
 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state {
    if (!title || !state) {
        return;
    }
    self.stateTitleDictionary[@(state)] = title;
    self.label.text = self.stateTitleDictionary[@(self.state)];
}


#pragma mark - 懒加载
// 懒加载 保存各个状态下对应的文字的字典
- (NSMutableDictionary *)stateTitleDictionary {
    if (!_stateTitleDictionary) {
        self.stateTitleDictionary = [NSMutableDictionary dictionary];
    }
    return _stateTitleDictionary;
}


@end
