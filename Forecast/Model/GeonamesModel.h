//
//  GeonamesModel.h
//  Forecast
//
//  Created by luck-mac on 15/5/6.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface GeonamesModel : NSObject
@property (strong,nonatomic) NSString *adminCode1;
@property (strong,nonatomic) NSString *lng;
@property (strong,nonatomic) NSNumber *geonameId;
@property (strong,nonatomic) NSString *toponymName;
@property (strong,nonatomic) NSString *countryId;
@property (strong,nonatomic) NSString *fcl;
@property (strong,nonatomic) NSNumber *population;
@property (strong,nonatomic) NSString *countryCode;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *fclName;
@property (strong,nonatomic) NSString *countryName;
@property (strong,nonatomic) NSString *fcodeName;
@property (strong,nonatomic) NSString *adminName1;
@property (strong,nonatomic) NSString *lat;
@property (strong,nonatomic) NSString *fcode;
@end
