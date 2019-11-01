//
//  TWJTemperature.h
//  TWJ
//
//  Created by ydd on 2019/8/29.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWJTemperatureModel : NSObject

@property (nonatomic,copy)NSString *temperature;
@property (nonatomic,copy)NSString *timeStamp;//时间戳
@property (nonatomic,copy)NSString *timeString;//时间字符串分钟，偏于搜每分钟如 yyyy年MM月dd日 HH时mm分
@property (nonatomic,copy)NSString *babyAddTime;

@end

NS_ASSUME_NONNULL_END
