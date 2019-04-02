/**
 -  MiddleLoadingView.m
 -  TWBK
 -  Created by calvin_tse on 2017/5/1.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是TWBK v2.1.0.新增需求.
 -  1、如果打开的页面内容需要进行网络请求，在网络请求完成之前页面中间显示该加载动画
 -  2、网络请求完成后，该加载动画隐藏，页面对应的内容显示
 */

#import "MiddleLoadingView.h"
#import "Masonry.h"

@interface MiddleLoadingView ()
/**
 中间的显示loading图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *middleLoadingImageView;
/**
 文字信息label
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end


@implementation MiddleLoadingView
/**
 快速创建对象
 
 @return 网络loading视图
 */
+ (instancetype)middleLoadingView {
    return [[NSBundle mainBundle] loadNibNamed:@"MiddleLoadingView" owner:nil options:nil].lastObject;
}


/**
 如果需要透明,则更改当前视图的UI效果

 @param isTransparent 是否需要透明
 */
- (void)setIsTransparent:(BOOL)isTransparent {
    _isTransparent = isTransparent;
    if (isTransparent) {
        self.backgroundColor = [UIColor clearColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}


/**
 设置label文字内容

 @param title 文字内容
 */
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}


/**
 根据样式(踩单车或者地球转),显示不同的背景图片

 @param type 样式(踩单车或者地球转)
 */
- (void)setType:(MiddleLoadingType)type {
    _type = type;
    
    // 设置动画图片数组
    NSMutableArray *imageArray = [NSMutableArray array];
    
    if (MiddleLoadingTypeBike == type) {
        for (int i = 1; i <= 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"loading_%d",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [imageArray addObject:image];
        }
    } else {
        for (int i = 1; i <= 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"mian_loading_0%d",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [imageArray addObject:image];
        }
    }
    
    // 设置图片imageView约束
    [_middleLoadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    // 设置文字label约束
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLoadingImageView.mas_bottom);
        make.centerX.equalTo(self);
    }];
    
    _middleLoadingImageView.animationImages = imageArray;
    CGFloat animationDuration = 0.95f;
    _middleLoadingImageView.animationDuration = animationDuration;
    [_middleLoadingImageView startAnimating];
}


@end
