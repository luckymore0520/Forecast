//
//  WeatherDetailViewController.m
//  Forecast
//
//  Created by luck-mac on 15/5/25.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "DateUtils.h"
@interface WeatherDetailViewController ()
@property (nonatomic,strong) DailyDataModel* weather;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//总结
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
//日出
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
//日落
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
//降雨
@property (weak, nonatomic) IBOutlet UILabel *rainPosibilityLabel;
//湿度
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
//月相
@property (weak, nonatomic) IBOutlet UILabel *moonPhaseLabel;
//风速
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
//风力
@property (weak, nonatomic) IBOutlet UILabel *windBearingLabel;
//气压
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
//臭氧
@property (weak, nonatomic) IBOutlet UILabel *ozoneLabel;

@property (nonatomic,strong) NSArray* labelArrays;
@end

@implementation WeatherDetailViewController

-(instancetype) initWithWeatherData:(DailyDataModel*)weather {
    if (self = [self initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.weather = weather;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    _labelArrays = @[_sunsetLabel,_sunriseLabel,_rainPosibilityLabel,_humidityLabel,_moonPhaseLabel,_windBearingLabel,_windSpeedLabel,_pressureLabel,_ozoneLabel];
    for (UILabel* label
         in _labelArrays) {
        label.alpha = 0;
    }
}

- (void) initView {
    [_timeLabel setText:[DateUtils dateTimeOfDate:[NSDate dateWithTimeIntervalSince1970:_weather.time.doubleValue]]];
    [_descriptionLabel setText:_weather.summary];
    
    [_sunriseLabel setText:[DateUtils detailTimeOfDate:[NSDate dateWithTimeIntervalSince1970:_weather.sunriseTime.doubleValue]]];
     [_sunsetLabel setText:[DateUtils detailTimeOfDate:[NSDate dateWithTimeIntervalSince1970:_weather.sunsetTime.doubleValue]]];
    
    [_rainPosibilityLabel setText:[NSString stringWithFormat:@"%.2f%@",_weather.precipIntensity.doubleValue * 100 , @"%"]];
    [_humidityLabel setText:[NSString stringWithFormat:@"%.2f%@",_weather.humidity.doubleValue * 100 , @"%"]];
    
    [_moonPhaseLabel setText:_weather.moonPhase];
    
    [_windSpeedLabel setText:[NSString stringWithFormat:@"%.2lf",_weather.windSpeed.doubleValue]];
    [_windBearingLabel setText:[NSString stringWithFormat:@"%d",_weather.windBearing.integerValue]];
    
    [_pressureLabel setText:_weather.pressure];
    [_ozoneLabel setText:_weather.ozone];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (UILabel* label in _labelArrays) {
        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 1;
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
