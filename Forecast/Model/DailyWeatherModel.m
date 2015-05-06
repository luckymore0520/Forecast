//
//  HourlyWeatherModel.m
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "DailyWeatherModel.h"

@implementation DailyWeatherModel
- (NSDictionary *)objectClassInArray
{
    return @{@"data" : [DailyDataModel class]};
}

@end
