//
//  LocationAPIHelper.h
//  Forecast
//
//  Created by luck-mac on 15/5/6.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LocationResultModel.h"
@protocol LocationAPIDelegate<NSObject>
@required
- (void)receiveLocationInfo:(LocationResultModel*)location;
@end
@interface LocationAPIHelper : NSObject
@property (nonatomic,weak) id<LocationAPIDelegate> delegate;
- (void)getLocationInfosWithKeyword:(NSString*)keyword;
@end
