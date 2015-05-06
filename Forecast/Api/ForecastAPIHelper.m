//
//  ForecastAPIHelper.m
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "ForecastAPIHelper.h"
#import "AFHTTPRequestOperationManager.h"
#define APIURL @"https://api.forecast.io/forecast/7d5030393da9e19f6545f1b219c90690/"
@implementation ForecastAPIHelper
- (void)getWeatherDataOfLocation:(CGPoint)location {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@%f,%f",APIURL,location.x,location.y];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.request.URL.absoluteString);
        [self handleData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)handleData:(id)responseObject
{
    NSError* error = [[NSError alloc]init];
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
    if (resultDict) {
        WeatherModel* weatherModel = [WeatherModel objectWithKeyValues:resultDict];
        [_delegate receiveWeatherInfo:weatherModel];
    }
}

@end
