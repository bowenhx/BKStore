/**
 -  AppListViewController.m
 -  BKStore
 -  Created by calvin_tse on 2017/6/2.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是显示app列表的控制器
 */

#import "AppListViewController.h"
#import "AppListCell.h"
#import "Networking.h"
#import "AppListModel.h"
#import "YYModel.h"
#import "ZoomRefreshHeader.h"
#import "TitleRefreshAutoFooter.h"
#import "AppDetailViewController.h"
#import "DefineFile.h"
#import "UIView+loadingViewAdd.h"
// cell缓存标识符
static NSString *appListCellID = @"AppListCellID";
#pragma mark - 属性
@interface AppListViewController () <UITableViewDelegate, UITableViewDataSource>
/**
 记录当前的page参数
 */
@property (assign, nonatomic) NSInteger currentPage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 数据源数组
 */
@property (strong, nonatomic) NSMutableArray <AppListModel *> *appListModelDataSource;
@end
#pragma mark - 方法
@implementation AppListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    _appListModelDataSource = [NSMutableArray array];
    [self.tableView.header beginRefreshing];
}


/**
 设置UI
 */
- (void)setupUI {
    self.title = @"内测列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = 100;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.header = [ZoomRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableView.footer = [TitleRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [_tableView registerNib:[UINib nibWithNibName:@"AppListCell" bundle:nil] forCellReuseIdentifier:appListCellID];
}


#pragma mark - 网络数据部分
/**
 加载网络数据
 */
- (void)loadData {
    BOOL isPullDown = [self.tableView.header isRefreshing];
    BOOL isPullup = [self.tableView.footer isRefreshing];
    
    if (isPullDown) {
        _currentPage = 1;
    } else if (isPullup) {
        _currentPage++;
    }
    
    NSDictionary *params = @{
                             @"username" : @"store",
                             @"password" : @"123456",
                             @"page" : @(_currentPage).description
                             };
    [[Networking share] post:APPLIST_URL
                      params:params
                  completion:^(NetworkModel *model, NSString *netErr) {
                      if (netErr) {
                          @WEAKSELF(self);
                          [self.view showLoadFailViewWithCompletion:^{
                              [selfWeak.tableView.header beginRefreshing];
                          }];
                      } else if (1 == model.status) {
                          NSMutableArray *tempArray = [NSMutableArray array];
                          for (NSDictionary *dict in model.data) {
                              AppListModel *appListModel = [AppListModel yy_modelWithDictionary:dict];
                              [tempArray addObject:appListModel];
                          }
                          
                          if (isPullDown) {
                              _appListModelDataSource = tempArray;
                          } else if (isPullup) {
                              [_appListModelDataSource addObjectsFromArray:tempArray];
                          }
                          
                          // 更新tableView的UI
                          [self.tableView reloadData];
                      }
                      
                      if (isPullDown) {
                          [self.tableView.header endRefreshing];
                      } else if (isPullup) {
                          [self.tableView.footer endRefreshing];
                      }
                  }];
}


#pragma mark - UITableViewDataSource - tableView数据源方法
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appListModelDataSource.count;
}


// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:appListCellID forIndexPath:indexPath];
    if (self.appListModelDataSource.count) {
        cell.appListModel = self.appListModelDataSource[indexPath.row];
        return cell;
    }
    return nil;
}


#pragma mark - UITableViewDelegate - tableView代理方法
// 点击cell时调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转到App对应的详情控制器
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDetailViewController *detailViewController = [[AppDetailViewController alloc] initWithAppListModel:_appListModelDataSource[indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
