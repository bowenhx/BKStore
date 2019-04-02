/**
 -  TitleRefreshBackFooter.m
 -  TWBK
 -  Created by calvin_tse on 2017/5/21.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是会回弹到底部的自定义上拉刷新控件.为TWBK2.1添加.
 */

#import "MJRefresh.h"

/**
 会回弹到底部的自定义上拉刷新控件
 */
@interface TitleRefreshBackFooter : MJRefreshBackFooter
/**
 设置控件不同状态下的文字信息
 
 @param title 文字信息
 @param state 控件的状态
 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;
@end
