/**
 -  AppInfoModel.h
 -  BKStore
 -  Created by calvin_tse on 2017/6/2.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是单个App的model里面的另一个包含详细信息的model
 */

#import <Foundation/Foundation.h>

/**
 这是单个App的model里面的另一个包含详细信息的model
 */
@interface AppInfoModel : NSObject
@property (nonatomic, copy) NSString *system;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *build;
@property (nonatomic, copy) NSString *pkg;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *temps;
@end
