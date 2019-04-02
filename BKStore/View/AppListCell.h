/**
 -  AppListCell.h
 -  BKStore
 -  Created by calvin_tse on 2017/6/2.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是显示单个app信息的cell
 */

#import <UIKit/UIKit.h>
#import "AppListModel.h"

/**
 App列表cell
 */
@interface AppListCell : UITableViewCell
@property (nonatomic, strong) AppListModel *appListModel;
@end
