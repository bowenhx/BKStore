/**
 -  AppListModel.m
 -  BKStore
 -  Created by calvin_tse on 2017/6/2.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是单个app对应的model
 */

#import "AppListModel.h"
#import "YYModel.h"

@implementation AppListModel
- (NSString *)description {
    return [self yy_modelDescription];
}
@end
