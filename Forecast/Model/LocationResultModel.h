//
//  LocationResultModel.h
//  Forecast
//
//  Created by luck-mac on 15/5/6.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "GeonamesModel.h"
@interface LocationResultModel : NSObject
@property (retain,nonatomic) NSNumber *totalResultsCount;
@property (retain,nonatomic) NSMutableArray *geonames;
@end
