//
//  LocationAPIHelper.m
//  Forecast
//
//  Created by luck-mac on 15/5/6.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "LocationAPIHelper.h"
#import "AFHTTPRequestOperationManager.h"
#define APIURL @"http://api.geonames.org/searchJSON?maxRows=20&username=kswangk"
@implementation LocationAPIHelper
- (void)getLocationInfosWithKeyword:(NSString*)keyword {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:APIURL parameters:@{@"q":keyword} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        LocationResultModel* model = [LocationResultModel objectWithKeyValues:resultDict];
        [_delegate receiveLocationInfo:model];
    }
}
@end
