//
//  DailyWeatherCell.h
//  Forecast
//
//  Created by luck-mac on 15/5/2.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyDataModel.h"
@interface DailyWeatherCell : UICollectionViewCell
- (void) updateWithWeather:(DailyDataModel*)weather isC:(BOOL)isC;
@end
