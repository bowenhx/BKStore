/**
 -  AppListCell.m
 -  BKStore
 -  Created by calvin_tse on 2017/6/2.
 -  Copyright © 2017年 calvin_tse. All rights reserved.
 -  说明:这是显示单个app信息的cell
 */

#import "AppListCell.h"
#import "UIImageView+WebCache.h"

@interface AppListCell ()
/**
 app图标imageView
 */
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
/**
 ipa包名称label
 */
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
/**
 版本名label
 */
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
/**
 版本号label
 */
@property (weak, nonatomic) IBOutlet UILabel *buildLabel;
/**
 发布时间label
 */
@property (weak, nonatomic) IBOutlet UILabel *dataTimeLabel;
/**
 显示"已安装"的label
 */
@property (weak, nonatomic) IBOutlet UILabel *installTagLabel;

@end

@implementation AppListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置App图标的圆角效果
    _iconImageView.layer.cornerRadius = 6.0f;
    _iconImageView.layer.masksToBounds = YES;
    
}

/**
 根据传入的model,更改UI

 @param appListModel cell对应的model
 */
- (void)setAppListModel:(AppListModel *)appListModel {
    _appListModel = appListModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:appListModel.info.icon] placeholderImage:[UIImage imageNamed:@"PlaceHolder"]];
    _subjectLabel.text = appListModel.info.name;
    _versionLabel.text = appListModel.info.version;
    _buildLabel.text = appListModel.info.build;
    _dataTimeLabel.text = appListModel.dateTime;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 已安装标志
    NSString *installID = [[NSUserDefaults standardUserDefaults] objectForKey:_appListModel.info.pkg];
    if(installID && [installID isEqualToString:_appListModel.id]) {
        _installTagLabel.hidden = NO;
    } else {
        _installTagLabel.hidden = YES;
    }
}

@end
