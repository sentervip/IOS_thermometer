//
//  TWJBlueToothManager.h
//  TWJ
//
//  Created by ydd on 2019/7/9.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TWJBlueToothManagerDelegate <NSObject>

- (void)connectDeviceSuccess;

@end

@interface TWJBlueToothManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic,assign)id<TWJBlueToothManagerDelegate> delegate;
@property (nonatomic,strong)TWJBabyInfoModel *babyInfo;


+ (TWJBlueToothManager *)shareManager;

- (void)scanDevice;

//连接设备
- (void)connectDeviceWithPeripheral:(CBPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END
