//
//  TemperatureTransformer.h
//  Forecast
//
//  Created by luck-mac on 15/5/2.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemperatureTransformer : NSObject
+(NSString*)fToC:(NSString*)fDegree;
+(NSString*)cToF:(NSString*)cDegree;
@end
