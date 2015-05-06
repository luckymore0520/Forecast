//
//  DataModel.m
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "HourlyDataModel.h"

@implementation HourlyDataModel
- (NSDictionary *)objectClassInArray
{
    return @{@"data" : [HourlyDataModel class]};
}
@end
