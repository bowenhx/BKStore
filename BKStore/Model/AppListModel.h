/**
 -  AppListModel.h
 -  BKStore
 -  Created by calvin_tse on 2017/6/2.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是单个app对应的model
 */

#import <Foundation/Foundation.h>
#import "AppInfoModel.h"

/**
 单个app对应的model
 */
@interface AppListModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *dateTime;
@property (nonatomic, strong) AppInfoModel *info;
@end
