//
//  LocationResultModel.m
//  Forecast
//
//  Created by luck-mac on 15/5/6.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "LocationResultModel.h"

@implementation LocationResultModel
- (NSDictionary *)objectClassInArray
{
    return @{@"geonames" : [GeonamesModel class]};
}
@end
