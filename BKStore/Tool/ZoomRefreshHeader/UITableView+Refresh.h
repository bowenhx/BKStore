/**
 -  UITableView+Refresh.h
 -  TWBK
 -  Created by calvin_tse on 2017/5/19.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是TWBk v2.1.0添加的新功能.目的是让自定义的tableView的上下拉刷新控件的文字状态,能够在"帖子详情"&"主题列表"界面下,显示不同的文字信息
 */

#import <UIKit/UIKit.h>
#import "ZoomRefreshHeader.h"
#import "TitleRefreshBackFooter.h"

@interface UITableView (Refresh)
/**
 取消掉默认的文字信息,根据传入的页码,替换掉本来默认的文字信息

 @param header 头部(下拉)刷新控件
 @param footer 尾部(上拉)刷新控件
 @param page 页码
 */
+ (void)resetTitleWithHeader:(ZoomRefreshHeader *)header withFooter:(TitleRefreshBackFooter *)footer withPage:(NSInteger)page;
@end
