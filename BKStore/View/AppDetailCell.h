/**
 -  AppDetailCell.h
 -  BKStore
 -  Created by calvin_tse on 2017/6/5.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是App详情控制器的第1(编程里的"1")个cell,用来显示App详细信息
 */

#import <UIKit/UIKit.h>
#import "AppDetailModel.h"

/**
 App详情cell代理协议
 */
@protocol AppDetailCellDelegate <NSObject>
/**
 点击cell的"安装"按钮的时候调用

 @param webView 回传webView
 */
- (void)downloadButtonDidClickWithWebView:(UIWebView *)webView;
@end


@interface AppDetailCell : UITableViewCell
@property (nonatomic, strong) AppDetailModel *appDetailModel;
@property (nonatomic, weak) id <AppDetailCellDelegate> delegate;
#pragma mark - UI属性
/**
 展示更新内容的webView(同时也负责下载App)
 */
@property (weak, nonatomic) IBOutlet UIWebView *htmlDateWebView;
/**
 "下载"按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@end
