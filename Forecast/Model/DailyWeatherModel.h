//
//  HourlyWeatherModel.h
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "DailyDataModel.h"
@interface DailyWeatherModel : NSObject
@property (strong,nonatomic) NSString *summary;
@property (strong,nonatomic) NSString *icon;
@property (strong,nonatomic) NSMutableArray *data;
@end

