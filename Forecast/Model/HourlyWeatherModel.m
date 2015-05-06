//
//  HourlyWeatherModel.m
//  Forecast
//
//  Created by luck-mac on 15/4/28.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "HourlyWeatherModel.h"
@implementation HourlyWeatherModel
- (NSDictionary *)objectClassInArray
{
    return @{@"data" : [HourlyDataModel class]};
}
@end
