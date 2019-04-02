/**
 -  AppDetailViewController.h
 -  BKStore
 -  Created by calvin_tse on 2017/6/4.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:显示App详情的控制器
 */

#import <UIKit/UIKit.h>
#import "AppListModel.h"

/**
 App详情控制器
 */
@interface AppDetailViewController : UIViewController
/**
 自定义构造方法

 @param appListModel app模型
 @return 根据模型生成好的App详情控制器
 */
- (instancetype)initWithAppListModel:(AppListModel *)appListModel;
@end
