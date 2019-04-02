/**
 -  ZoomRefreshHeader.h
 -  TWBK
 -  Created by calvin_tse on 2017/5/3.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:该头部刷新控件为TWBK v2.1.0.添加.
 -  继承自MJRefreshHeader,对三种状态的UI进行了自定义
 -  "爸妈图书馆"&"每日任务"模块的tableView有组头,所以为了减小头部控件距离tableView的距离,添加了一个contentOffsetY属性用来设置内部控件的垂直偏移值
 */

#import "MJRefresh.h"

/**
 自定义头部刷新控件
 */
@interface ZoomRefreshHeader : MJRefreshHeader
/**
 设置内部控件的垂直偏移值
 */
@property (nonatomic, assign) CGFloat contentOffsetY;


/**
 设置控件不同状态下的文字信息

 @param title 文字信息
 @param state 控件的状态
 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;
@end
