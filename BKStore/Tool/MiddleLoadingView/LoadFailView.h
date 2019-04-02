/**
 -  LoadFailView.h
 -  TWBK
 -  Created by calvin_tse on 2017/5/23.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是加载失败的时候显示的视图,为TWBKv2.1添加
 */

#import <UIKit/UIKit.h>
// 定义一个block类型,返回值和参数都为空
typedef void(^emptyBlock)();
/**
 加载失败时显示的视图
 */
@interface LoadFailView : UIView
/**
 自定义构造方法
 
 @param completion 点击加载失败视图时执行的回调
 @return 加载失败视图
 */
- (instancetype)initWithCompletion:(emptyBlock)completion;
@end
