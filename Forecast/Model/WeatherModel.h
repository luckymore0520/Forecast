//
//  WeatherModel.h
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "DailyWeatherModel.h"
#import "HourlyWeatherModel.h"
@interface WeatherModel : NSObject
@property (strong,nonatomic) NSString *latitude;
@property (strong,nonatomic) NSString *longitude;
@property (strong,nonatomic) NSString *timezone;
@property (retain,nonatomic) NSNumber *offset;
@property (strong,nonatomic) HourlyDataModel *currently;
@property (strong,nonatomic) HourlyWeatherModel *hourly;
@property (strong,nonatomic) DailyWeatherModel *daily;
@property (strong,nonatomic) NSMutableArray *flags;
@end
