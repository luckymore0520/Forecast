//
//  WeatherDetailViewController.h
//  Forecast
//
//  Created by luck-mac on 15/5/25.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyDataModel.h"

@interface WeatherDetailViewController : UIViewController
-(instancetype) initWithWeatherData:(DailyDataModel*)weather;
@end
