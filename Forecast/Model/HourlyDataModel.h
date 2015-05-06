//
//  DataModel.h
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface HourlyDataModel : NSObject
@property (strong,nonatomic) NSNumber *time;
@property (strong,nonatomic) NSString *summary;
@property (strong,nonatomic) NSString *icon;
@property (strong,nonatomic) NSNumber *precipIntensity;
@property (strong,nonatomic) NSNumber *precipProbability;
@property (strong,nonatomic) NSString *temperature;
@property (strong,nonatomic) NSString *apparentTemperature;
@property (strong,nonatomic) NSString *dewPoint;
@property (strong,nonatomic) NSString *humidity;
@property (strong,nonatomic) NSString *windSpeed;
@property (strong,nonatomic) NSNumber *windBearing;
@property (strong,nonatomic) NSString *cloudCover;
@property (strong,nonatomic) NSString *pressure;
@property (strong,nonatomic) NSString *ozone;
@end
