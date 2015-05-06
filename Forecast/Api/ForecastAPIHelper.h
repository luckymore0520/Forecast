//
//  ForecastAPIHelper.h
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherModel.h"
@protocol WeatherApiDelegate<NSObject>
@required
- (void)receiveWeatherInfo:(WeatherModel*)weather;
@end
@interface ForecastAPIHelper : NSObject
@property (nonatomic,weak) id<WeatherApiDelegate> delegate;
- (void)getWeatherDataOfLocation:(CGPoint)location;
@end
