/**
 -  MiddleLoadingView.h
 -  TWBK
 -  Created by calvin_tse on 2017/5/1.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是TWBK v2.1.0.新增需求.
 -  1、如果打开的页面内容需要进行网络请求，在网络请求完成之前页面中间显示该加载动画
 -  2、网络请求完成后，该加载动画隐藏，页面对应的内容显示
 */

#import <UIKit/UIKit.h>
/**
 中间loading视图的两种样式
 
 - MiddleLoadingTypeBike: 踩单车样式
 - MiddleLoadingTypeEarth: 地球转样式
 */
typedef NS_ENUM(NSInteger, MiddleLoadingType) {
    MiddleLoadingTypeBike  = 0,
    MiddleLoadingTypeEarth = 1,
};

/**
 网络loading视图
 */
@interface MiddleLoadingView : UIView
/**
 快速创建对象

 @return 网络loading视图
 */
+ (instancetype)middleLoadingView;


/**
 是否具有透明效果
 */
@property (nonatomic, assign) BOOL isTransparent;
/**
 要显示的文字内容
 */
@property (nonatomic, copy) NSString *title;
/**
 中间loading视图的两种样式
 */
@property (nonatomic, assign) MiddleLoadingType type;
@end
