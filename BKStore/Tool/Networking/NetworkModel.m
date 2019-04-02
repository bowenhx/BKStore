/**
 -  NetworkModel.m
 -  BKSDK
 -  Created by HY on 16/11/10.
 -  Copyright © 2016年 BaByKingdom. All rights reserved.
 */

#import "NetworkModel.h"

@implementation NetworkModel


- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];

    if ([key isEqualToString:@"status"])
    {
        if ([value integerValue] == -2)
        {
            //清除用户基本信息，这里待解决
            //**SDK注意要修改//[BNetworkConfig clearUserInfoData];
        }
    }
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
