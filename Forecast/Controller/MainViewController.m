//
//  MainViewController.m
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "MainViewController.h"
#import "ForecastAPIHelper.h"
#import "TemperatureTransformer.h"
#import "DailyWeatherCell.h"
#import "SearchLocationViewController.h"
#import "MBProgressHud.h"
#import "WeatherDetailRootViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define LOCAL_LANG(LangKey) [[NSBundle mainBundle] localizedStringForKey:(LangKey) value:@"" table:nil]

@interface MainViewController ()<WeatherApiDelegate,CLLocationManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
//Label
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherSummeryLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heatIndex;
@property (weak, nonatomic) IBOutlet UIButton *unitButton;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;

@property (strong,nonatomic) WeatherModel* weather;
@property (strong,nonatomic) ForecastAPIHelper *helper;

@property (strong,nonatomic) CLLocationManager* locationManager;
@property (strong,nonatomic) NSArray* textLabelArray;
@property (nonatomic) BOOL hasGotNewData;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    if (![CLLocationManager locationServicesEnabled]) {
        [[[UIAlertView alloc]initWithTitle:LOCAL_LANG(@"Alert_Title_LocationNotSupported")
                                   message:LOCAL_LANG(@"Alert_Content_LocationNotSupported")
                                  delegate:self
                         cancelButtonTitle:LOCAL_LANG(@"BT_OK")
                         otherButtonTitles:nil, nil]show];
        return;
    }
    _hasGotNewData = NO;
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestAlwaysAuthorization];
    //设置代理
    _locationManager.delegate=self;
    //设置定位精度
    _locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    //启动跟踪定位
    [_locationManager startUpdatingLocation];
    [_locationManager requestWhenInUseAuthorization];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DailyWeatherCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DailyWeatherCell class])];
    _textLabelArray = @[_temperatureLabel,_highTemperatureLabel,_lowTemperatureLabel,_windLabel,_rainLabel,_humidLabel,_collectionView];
    [self setAllTextLabelHidden:YES withAnimate:NO];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weather"]) {
        [self receiveWeatherInfo:[WeatherModel objectWithKeyValues:[[NSUserDefaults standardUserDefaults] objectForKey:@"weather"]]];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Private
- (void) setAllTextLabelHidden:(BOOL)hidden withAnimate:(BOOL)animate{
    for (UIView* view in _textLabelArray) {
        if (animate) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = hidden? 0 : 1;
            }];
        } else {
            view.alpha = hidden? 0 : 1;
        }
    }
}

- (void)updateDegrees {
    if (self.unitButton.selected) {
        [_temperatureLabel setText:[TemperatureTransformer fToC:_temperatureLabel.text]];
        [_highTemperatureLabel setText:[TemperatureTransformer fToC:_highTemperatureLabel.text]];
        [_lowTemperatureLabel setText:[TemperatureTransformer fToC:_lowTemperatureLabel.text]];
    } else {
        [_temperatureLabel setText:[TemperatureTransformer cToF:_temperatureLabel.text]];
        [_highTemperatureLabel setText:[TemperatureTransformer cToF:_highTemperatureLabel.text]];
        [_lowTemperatureLabel setText:[TemperatureTransformer cToF:_lowTemperatureLabel.text]];
    }
}

#pragma mark -Public
- (void)setSelectedLocation:(GeonamesModel *)selectedLocation {
    [self.userLocationLabel setText:selectedLocation.name];
    [self getWeatherData:CGPointMake(selectedLocation.lat.floatValue, selectedLocation.lng.floatValue)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -API
- (void)getWeatherData:(CGPoint)location {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _helper = [[ForecastAPIHelper alloc] init];
    _helper.delegate = self;
    [_helper getWeatherDataOfLocation:location];
}

#pragma mark -ButtonAction
- (IBAction)changeUnit:(id)sender {
    _unitButton.selected = !_unitButton.selected;
    [self updateDegrees];
    [_collectionView reloadData];
}
- (IBAction)selectLocation:(id)sender {
    SearchLocationViewController* search = [[SearchLocationViewController alloc] initWithNibName:NSStringFromClass([SearchLocationViewController class]) bundle:nil];
    search.presenter = self;
    [self presentViewController:search animated:YES completion:nil];
}

#pragma mark -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    _hasGotNewData = YES;
    CLLocation *newLocation = [locations lastObject];
    CGFloat longitute = newLocation.coordinate.longitude;
    CGFloat latitude = newLocation.coordinate.latitude;
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error) {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             [self.userLocationLabel setText:city];
         }
     }];
    [self getWeatherData:CGPointMake(latitude, longitute)];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (self.hasGotNewData) {
        return;
    }
    [[[UIAlertView alloc]initWithTitle:LOCAL_LANG(@"Alert_Title_LocationNotSupported")
                               message:LOCAL_LANG(@"Alert_Content_LocationNotSupported")
                              delegate:self
                     cancelButtonTitle:LOCAL_LANG(@"BT_OK")
                     otherButtonTitles:nil, nil]show];
          }


#pragma mark -ApiDelegate
- (void)receiveWeatherInfo:(WeatherModel *)weather {
    [[NSUserDefaults standardUserDefaults] setObject:weather.keyValues forKey:@"weather"];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    _weather = weather; 
    if (!weather) {
        return;
    }
    HourlyDataModel* current = weather.currently;
    DailyDataModel* today = [DailyDataModel objectWithKeyValues:weather.daily.data[0]];
    [_weatherSummeryLabel setText:current.summary];
    [_weatherIconImageView setImage:[UIImage imageNamed:current.icon]];
    [_humidLabel setText:[NSString stringWithFormat:@"%.2lf",current.humidity.floatValue]];
    [_windLabel setText:[NSString stringWithFormat:@"%.2lf",current.windSpeed.floatValue]];
    [_rainLabel setText:[NSString stringWithFormat:@"%.2lf",current.precipIntensity.floatValue]];
    //温度
    [_temperatureLabel setText:[NSString stringWithFormat:@"%.2lf",current.temperature.floatValue]];
    [_highTemperatureLabel setText:[NSString stringWithFormat:@"%.2lf",today.temperatureMax.floatValue]];
    [_lowTemperatureLabel setText:[NSString stringWithFormat:@"%.2lf",today.temperatureMin.floatValue]];
    if (self.unitButton.selected) {
        [self updateDegrees];
    }
    //温度足够低的情况下，则显示冬天的图
    if (current.temperature.floatValue <= 60) {
        self.heatIndex.image = [UIImage imageNamed:@"heatindexWinter"];
        self.lowTemperatureLabel.textColor = [UIColor colorWithRed:0 green:121/255.0 blue:1 alpha:1];
        self.highTemperatureLabel.textColor = [UIColor colorWithRed:245/255.0 green:6/255.0 blue:93/255.0 alpha:1];
    }
    [_collectionView reloadData];
    [self setAllTextLabelHidden:NO withAnimate:YES];
}

#pragma mark -CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _weather.daily.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DailyWeatherCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DailyWeatherCell class]) forIndexPath:indexPath];
    DailyDataModel* model = [DailyDataModel objectWithKeyValues:_weather.daily.data[indexPath.row]];
    [cell updateWithWeather:model isC:_unitButton.selected];
    return cell;
}


#pragma mark -CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WeatherDetailRootViewController* weatherDetailVC = [[WeatherDetailRootViewController alloc] initWithWeatherData:_weather.daily.data currentIndex:indexPath.row];
    [self.navigationController pushViewController:weatherDetailVC animated:YES];
}
@end
