/**
 -  LoadFailView.m
 -  TWBK
 -  Created by calvin_tse on 2017/5/23.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是加载失败的时候显示的视图,为TWBKv2.1添加
 */

#import "LoadFailView.h"
#import "Masonry.h"

@interface LoadFailView ()
/**
 点击加载失败视图时执行的block回调
 */
@property (nonatomic, copy) emptyBlock completion;
@end

@implementation LoadFailView
/**
 自定义构造方法

 @param completion 点击加载失败视图时执行的回调
 @return 加载失败视图
 */
- (instancetype)initWithCompletion:(emptyBlock)completion {
    if (self = [super init]) {
        self.completion = completion;
        [self setupUI];
    }
    return self;
}


/**
 设置UI
 */
- (void)setupUI {
    // 先放置一个用来显示背景灰色的视图,再放置一个label和imageView来显示提示信息和卡通图片,最后再放置1个透明按钮在整个视图的上面
    // 1.背景视图
    UIView *backgroundView = [[UIView alloc] init];
    [self addSubview:backgroundView];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 2.卡通图片imageView
    UIImageView *loadFailImageView = [[UIImageView alloc] init];
    [self addSubview:loadFailImageView];
    loadFailImageView.image = [UIImage imageNamed:@"mian_loading_3"];
    CGFloat loadFailImageViewWidth = 90;
    [loadFailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(loadFailImageViewWidth, loadFailImageViewWidth));
    }];
    
    // 3.提示信息label
    UILabel *loadFailLabel = [[UILabel alloc] init];
    [self addSubview:loadFailLabel];
    loadFailLabel.text = @"失敗了,再點一下試試吧!";
    loadFailLabel.textColor = [UIColor lightGrayColor];
    [loadFailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(loadFailImageView.mas_bottom);
    }];
    
    // 4.按钮
    UIButton *loadFailButton = [[UIButton alloc] init];
    [self addSubview:loadFailButton];
    loadFailButton.backgroundColor = [UIColor clearColor];
    [loadFailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    // 添加监听事件
    [loadFailButton addTarget:self action:@selector(clickLoadFailButton) forControlEvents:UIControlEventTouchUpInside];
}


/**
 按钮监听事件
 */
- (void)clickLoadFailButton {
    [self removeFromSuperview];
    // 执行回调
    if (self.completion) {
        self.completion();
    }
}


@end
