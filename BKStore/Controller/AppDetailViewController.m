/**
 -  AppDetailViewController.m
 -  BKStore
 -  Created by calvin_tse on 2017/6/4.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:显示App详情的控制器
 */

#import "AppDetailViewController.h"
#import "Masonry.h"
#import "DefineFile.h"
#import "AppListCell.h"
#import "AppDetailCell.h"
#import "Networking.h"
#import "MBProgressHUD+Add.h"
#import "YYModel.h"
#import "UIView+loadingViewAdd.h"

// cell缓存标识符
static NSString *appListCellID = @"AppListCellID";
static NSString *appDetailCellID = @"AppDetailCellID";

#pragma mark - 属性
@interface AppDetailViewController () <UITableViewDataSource,
                                       UITableViewDelegate,
                                       UIAlertViewDelegate,
                                       AppDetailCellDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic, strong) AppListModel *appListModel;
@property (nonatomic, strong) AppDetailModel *appDetailModel;
@end


#pragma mark - 方法
@implementation AppDetailViewController
/**
 自定义构造方法
 
 @param appListModel app模型
 @return 根据模型生成好的App详情控制器
 */

- (instancetype)initWithAppListModel:(AppListModel *)appListModel {
    if (self = [super init]) {
        _appListModel = appListModel;
        [self setupUI];
        [self loadData];
    }
    return self;
}


#pragma mark - UI部分
/**
 设置UI
 */
- (void)setupUI {
    // 设置当前控制器的UI
    [self setupSelf];
    // 设置主体的tableView的UI
    [self setupTableView];
}


/**
 设置当前控制器的UI
 */
- (void)setupSelf {
    self.title = _appListModel.info.name;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}


/**
 设置主体的tableView的UI
 */
- (void)setupTableView {
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAVIGATIONBAR_HEIGHT);
    }];
    // 注册顶部第0个cell,样式就是列表控制器的cell
    [tableView registerNib:[UINib nibWithNibName:@"AppListCell" bundle:nil] forCellReuseIdentifier:appListCellID];
    // 注册第1个cell
    [tableView registerNib:[UINib nibWithNibName:@"AppDetailCell" bundle:nil] forCellReuseIdentifier:appDetailCellID];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSelectionStyleBlue;
}


#pragma mark - 网络数据部分
/**
 加载网络数据
 */
- (void)loadData {
    NSDictionary *params = @{
                             @"username" : @"store",
                             @"password" : @"123456",
                             @"id" : _appListModel.id
                             };
    [self.view showLoadingViewWithType:MiddleLoadingTypeBike withTransparent:NO withTitle:nil];
    [[Networking share] post:APPDETAIL_URL
                      params:params
                  completion:^(NetworkModel *model, NSString *netErr) {
                      [self.view removeLoadingView];
                      if (netErr) {
                          [self.view showHUDTitleView:netErr image:nil];
                          @WEAKSELF(self);
                          [self.view showLoadFailViewWithCompletion:^{
                              [selfWeak loadData];
                          }];
                      } else if (1 == model.status) {
                          if ([model.data isKindOfClass:[NSDictionary class]]) {
                              _appDetailModel = [AppDetailModel yy_modelWithDictionary:model.data];
                              [self.tableView reloadData];
                          }
                      }
                  }];
}


#pragma mark - UITableViewDataSource - tableView数据源方法
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        AppListCell *appListCell = [tableView dequeueReusableCellWithIdentifier:appListCellID forIndexPath:indexPath];
        appListCell.appListModel = self.appListModel;
        appListCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        return appListCell;
    } else if (1 == indexPath.row) {
        AppDetailCell *appDetailCell = [tableView dequeueReusableCellWithIdentifier:appDetailCellID forIndexPath:indexPath];
        appDetailCell.appDetailModel = _appDetailModel;
        appDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置App详情cell的代理对象
        appDetailCell.delegate = self;
        return appDetailCell;
    }
    return nil;
}


#pragma mark - UITableViewDelegate - tableView代理方法
// 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        return 100;
    } else {
        return 600;
    }
}


// 选中cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 如果选中的cell不是第0个cell的话,直接return不做处理
    if (indexPath.row != 0) {
        return;
    }
    
    // 创建弹窗
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此应用还没有安装, 是否安装?"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"安装", nil];
    
    // 准备App bundleIdentifier 和 App URLScheme的字典
    NSDictionary *dict = @{
                           BKTW_BUNDLE_IDENTIFIER : BKTW_URL_SCHEME,
                           BKHK_BUNDLE_IDENTIFIER : BKHK_URL_SCHEME,
                           BKSZ_BUNDLE_IDENTIFIER : BKSZ_URL_SCHEME,
                           EKHK_BUNDLE_IDENTIFIER : EKHK_URL_SCHEME
                           };
    
    NSString *urlString = dict[_appListModel.info.pkg];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[dict allKeys] containsObject:_appListModel.info.pkg]
        && [[UIApplication sharedApplication] canOpenURL:url]) {
        // 手机已经安装了,就直接打开对应App
        [[UIApplication sharedApplication] openURL:url];
    } else {
        // 手机没有安装对应App的话,则显示弹窗,提示下载
        [alert show];
    }
}


#pragma mark - AppDetailCellDelegate - 第1个详情cell的代理方法
- (void)downloadButtonDidClickWithWebView:(UIWebView *)webView {
    // 让cell的webView进行下载操作
    [self downloadAppWithWebView:webView];
}


#pragma mark - UIAlertViewDelegate - 弹窗代理方法
// 点击alertView的按钮的时候调用
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // 点击"是"进行下载操作
    if (1 == buttonIndex) {
        AppDetailCell *detailCell = self.tableView.visibleCells[1];
        // 点击按钮后不允许再点击
        detailCell.downloadButton.enabled = NO;
        [self downloadAppWithWebView:detailCell.htmlDateWebView];
    }
}


#pragma mark - 内部使用的私有方法
/**
 让webView执行下载App的操作

 @param webView 进行下载操作的webView
 */
- (void)downloadAppWithWebView:(UIWebView *)webView {
    // webView加载网络请求进行下载
    NSString *urlString = [DOWNLOAD_PREFIX stringByAppendingString:_appDetailModel.ipa];
    NSURL *url = [NSURL URLWithString:urlString];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    // 保存安装标志
    [[NSUserDefaults standardUserDefaults] setObject:_appListModel.id forKey:_appDetailModel.info.pkg];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
