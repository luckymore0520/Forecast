//
//  MainViewController.h
//  Forecast
//
//  Created by luck-mac on 15/4/27.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeonamesModel.h"
@interface MainViewController : UIViewController
@property (nonatomic,strong) GeonamesModel* selectedLocation;
@end
