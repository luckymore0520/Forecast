//
//  WeatherDetailRootViewController.m
//  Forecast
//
//  Created by luck-mac on 15/5/29.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "WeatherDetailRootViewController.h"
#import "WeatherDetailViewController.h"
@interface WeatherDetailRootViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray* weatherData;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation WeatherDetailRootViewController

- (instancetype) initWithWeatherData:(NSArray*)weatherData currentIndex:(NSInteger) index {
    if (self = [self init]) {
        self.weatherData = weatherData;
        self.currentIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.scrollView.contentSize = CGSizeMake(screenSize.width * _weatherData.count, 0);
    int index = 0 ;
    for (NSDictionary* model in self.weatherData) {
        WeatherDetailViewController* detailViewController = [[WeatherDetailViewController alloc] initWithWeatherData:[DailyDataModel objectWithKeyValues:model]];
        [self addChildViewController:detailViewController];
        detailViewController.view.frame = CGRectMake(index * screenSize.width, 0, screenSize.width, screenSize.height);
        [self.scrollView addSubview:detailViewController.view];
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake(_currentIndex * screenSize.width, 0)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ButtonAction
- (IBAction)onBackButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
