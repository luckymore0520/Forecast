//
//  DailyWeatherCell.m
//  Forecast
//
//  Created by luck-mac on 15/5/2.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "DailyWeatherCell.h"
#import "DateUtils.h"
#import "TemperatureTransformer.h"
@interface DailyWeatherCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end
@implementation DailyWeatherCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)updateWithWeather:(DailyDataModel *)weather isC:(BOOL)isC{
    [_timeLabel setText:[DateUtils weekDayWithDate:[NSDate dateWithTimeIntervalSince1970:weather.time.integerValue]]];
    [_weatherIcon setImage:[UIImage imageNamed:weather.icon]];
    if (!isC) {
        [_temperatureLabel setText:[NSString stringWithFormat:@"%.0f°/%.0f°",weather.temperatureMin.floatValue,weather.temperatureMax.floatValue]];
    } else {
        [_temperatureLabel setText:[NSString stringWithFormat:@"%.0f°/%.0f°",[TemperatureTransformer fToC:weather.temperatureMin].floatValue,
            [TemperatureTransformer fToC:weather.temperatureMax].floatValue]];
    }
}

@end
