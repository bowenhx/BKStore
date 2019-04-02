/**
 -  AppInfoModel.m
 -  BKStore
 -  Created by calvin_tse on 2017/6/2.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是单个App的model里面的另一个包含详细信息的model
 */

#import "AppInfoModel.h"
#import "YYModel.h"

@implementation AppInfoModel

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
