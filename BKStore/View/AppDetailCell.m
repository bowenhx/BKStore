/**
 -  AppDetailCell.m
 -  BKStore
 -  Created by calvin_tse on 2017/6/5.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是App详情控制器的第1(编程里的"1")个cell,用来显示App详细信息
 */

#import "AppDetailCell.h"
#import <WebKit/WebKit.h>
#import "DefineFile.h"

@interface AppDetailCell ()
/**
 "发布者"label
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation AppDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置"下载"按钮的圆角效果
    _downloadButton.layer.cornerRadius = 3.0f;
    _downloadButton.layer.masksToBounds = YES;
    _downloadButton.layer.borderWidth = 1.0f;
    _downloadButton.layer.borderColor = [UIColor blueColor].CGColor;
}


// "下载"按钮监听事件
- (IBAction)clickDownloadButton:(UIButton *)sender {
    // 点击按钮后不允许再点击
    sender.enabled = NO;
    // 执行代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(downloadButtonDidClickWithWebView:)]) {
        [self.delegate downloadButtonDidClickWithWebView:_htmlDateWebView];
    }
}


/**
 根据外部传入的model,修改UI

 @param appDetailModel appDetailModel
 */
- (void)setAppDetailModel:(AppDetailModel *)appDetailModel {
    _appDetailModel = appDetailModel;
    
    _userNameLabel.text = appDetailModel.username;
    [_htmlDateWebView loadHTMLString:appDetailModel.htmldate baseURL:nil];
}


@end
