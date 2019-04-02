/**
 -  UITableView+Refresh.m
 -  TWBK
 -  Created by calvin_tse on 2017/5/19.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:这是TWBk v2.1.0添加的新功能.目的是让自定义的tableView的上下拉刷新控件的文字状态,能够在"帖子详情"&"主题列表"界面下,显示不同的文字信息
 */

#import "UITableView+Refresh.h"
@implementation UITableView (Refresh)
/**
 取消掉默认的文字信息,根据传入的页码,替换掉本来默认的文字信息
 
 @param header 想要修改的头部(下拉)刷新控件
 @param footer 想要修改的尾部(上拉)刷新控件
 @param page 页码
 */
+ (void)resetTitleWithHeader:(ZoomRefreshHeader *)header withFooter:(TitleRefreshBackFooter *)footer withPage:(NSInteger)page {
    if (page < 1) {
        page = 1;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (page <= 2) {
            // 设置文字
            [header setTitle:@"下拉加載首頁" forState:MJRefreshStateIdle];
            [header setTitle:@"鬆開加載首頁" forState:MJRefreshStatePulling];
            [header setTitle:@"正在載入首頁..." forState:MJRefreshStateRefreshing];
        } else {
            NSString *strIdleTemp = [NSString stringWithFormat:@"下拉加載第%d頁",(int)page - 1];
            NSString *strPullingTemp = [NSString stringWithFormat:@"鬆開加載第%d頁",(int)page - 1];
            NSString *strRefreshingTemp = [NSString stringWithFormat:@"正在載入..."];
            // 设置文字
            [header setTitle:strIdleTemp forState:MJRefreshStateIdle];
            [header setTitle:strPullingTemp forState:MJRefreshStatePulling];
            [header setTitle:strRefreshingTemp forState:MJRefreshStateRefreshing];
        }
        
        NSString *strIdle = [NSString stringWithFormat:@"上拉加載第%d頁",(int)page+1];
        NSString *strPulling = [NSString stringWithFormat:@"鬆開加載第%d頁",(int)page+1];
        NSString *strRefreshing = [NSString stringWithFormat:@"正在載入..."];
        [footer setTitle:strIdle forState:MJRefreshStateIdle];
        [footer setTitle:strPulling forState:MJRefreshStatePulling];
        [footer setTitle:strRefreshing forState:MJRefreshStateRefreshing];
    });
    
}

@end
