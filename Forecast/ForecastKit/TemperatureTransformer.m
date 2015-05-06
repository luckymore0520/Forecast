//
//  TemperatureTransformer.m
//  Forecast
//
//  Created by luck-mac on 15/5/2.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "TemperatureTransformer.h"

@implementation TemperatureTransformer
+(NSString *)fToC:(NSString *)fDegree {
    float f = fDegree.floatValue;
    return [NSString stringWithFormat:@"%.2f",(f - 32) / 1.8];
}

+ (NSString *)cToF:(NSString *)cDegree {
    float c = cDegree.floatValue;
    return [NSString stringWithFormat:@"%.2f",c * 1.8 + 32];
}
@end
