//
//  FCDataBaseManager.h
//  Meitong
//
//  Created by ydd on 2019/3/18.
//  Copyright © 2019年 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "TWJBabyInfoModel.h"
#import "TWJTemperatureModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWJDataBaseManager : NSObject
@property (nonatomic,assign)BOOL isHusShiDu;
+ (instancetype)sharedInstance;

#pragma mark 宝贝个人信息
- (void)insertBabyinfoWithModel:(TWJBabyInfoModel *)model;

- (void)deleteBabyinfo;

- (NSArray *)getAllBabyinfo;

- (void)deleteBabyWithModel:(TWJBabyInfoModel *)model;

#pragma mark 温度值
- (void)insertTemperatureWithModel:(TWJTemperatureModel *)model;

- (NSArray *)getTemperatureWithTime:(NSString *)time;

- (NSArray *)selectHigestTemperatrue:(NSString *)fromTime to:(NSString *)toTime;

@end

NS_ASSUME_NONNULL_END
