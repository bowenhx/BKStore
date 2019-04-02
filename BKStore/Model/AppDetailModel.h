/**
 -  AppDetailModel.h
 -  BKStore
 -  Created by calvin_tse on 2017/6/4.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:App详情model
 */

#import <Foundation/Foundation.h>
#import "AppInfoModel.h"

/**
 App详情model
 */
@interface AppDetailModel : NSObject
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *htmldate;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *ipa;
@property (nonatomic, strong) AppInfoModel *info;
@end
