//
//  WeatherDetailRootViewController.h
//  Forecast
//
//  Created by luck-mac on 15/5/29.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailRootViewController : UIViewController
- (instancetype) initWithWeatherData:(NSArray*)weatherData currentIndex:(NSInteger) index;
@end
