//
//  DailyDataModel.h
//  Forecast
//
//  Created by luck-mac on 15/4/28.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface DailyDataModel : NSObject
@property (strong,nonatomic) NSNumber *time;
@property (strong,nonatomic) NSString *summary;
@property (strong,nonatomic) NSString *icon;
@property (strong,nonatomic) NSNumber *sunriseTime;
@property (strong,nonatomic) NSNumber *sunsetTime;
@property (strong,nonatomic) NSString *moonPhase;
@property (strong,nonatomic) NSString *precipIntensity;
@property (strong,nonatomic) NSString *precipIntensityMax;
@property (strong,nonatomic) NSNumber *precipIntensityMaxTime;
@property (strong,nonatomic) NSNumber *precipProbability;
@property (strong,nonatomic) NSString *precipType;
@property (strong,nonatomic) NSString *temperatureMin;
@property (strong,nonatomic) NSNumber *temperatureMinTime;
@property (strong,nonatomic) NSString *temperatureMax;
@property (strong,nonatomic) NSNumber *temperatureMaxTime;
@property (strong,nonatomic) NSString *apparentTemperatureMin;
@property (strong,nonatomic) NSNumber *apparentTemperatureMinTime;
@property (strong,nonatomic) NSString *apparentTemperatureMax;
@property (strong,nonatomic) NSNumber *apparentTemperatureMaxTime;
@property (strong,nonatomic) NSString *dewPoint;
@property (strong,nonatomic) NSString *humidity;
@property (strong,nonatomic) NSString *windSpeed;
@property (strong,nonatomic) NSNumber *windBearing;
@property (strong,nonatomic) NSString *visibility;
@property (strong,nonatomic) NSString *cloudCover;
@property (strong,nonatomic) NSString *pressure;
@property (strong,nonatomic) NSString *ozone;
@end
