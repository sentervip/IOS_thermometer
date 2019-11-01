//
//  TWJBlueToothManager.m
//  TWJ
//
//  Created by ydd on 2019/7/9.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJBlueToothManager.h"


@interface TWJBlueToothManager ()

@property (nonatomic,strong)CBCentralManager *centralManager;
@property(nonatomic,strong)CBPeripheral *peripheral;
@property(nonatomic,strong)NSTimer *myTimer;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *addArray;

@end

@implementation TWJBlueToothManager

+ (TWJBlueToothManager *)shareManager {
    static TWJBlueToothManager *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstace;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [TWJBlueToothManager shareManager] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [TWJBlueToothManager shareManager];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
        return self;
    }
    return nil;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (TWJBabyInfoModel *)babyInfo {
    if (!_babyInfo) {
        NSArray *array = [[TWJDataBaseManager sharedInstance] getAllBabyinfo];
        if (array.count > 0) {
            _babyInfo = array[0];
        }
    }
    return _babyInfo;
}

//连接
- (void)connectDeviceWithPeripheral:(CBPeripheral *)peripheral
{
    [self.centralManager connectPeripheral:peripheral options:nil];
}

//扫描
- (void)scanDevice
{
    if (_centralManager == nil) {
//        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//        [_deviceDic removeAllObjects];
    }
}

//数据库录入数据6秒一次
- (void)saveTemData{
    self.addArray = self.dataArray;
    if (self.addArray.count > 0) {
        @autoreleasepool {
            float total = 0;
            for (NSString *value in self.addArray) {
                total += [value floatValue];
            }
            
            float tem = total/self.addArray.count;
            TWJTemperatureModel *model = [TWJTemperatureModel new];
            model.temperature = [NSString stringWithFormat:@"%.2f",tem];
            model.babyAddTime = self.babyInfo.addTime;
            model.timeStamp = [NSString getCurrentTimestamp];
            model.timeString = [NSString getCurrentDateStringWithFormate:@"yyyy年MM月dd日 HH时mm分"];
            [[TWJDataBaseManager sharedInstance] insertTemperatureWithModel:model];
        }
    }
}

#pragma mark CBCentralManagerDelegate
//开始搜索
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
        {
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            // 开始扫描周围的外设。
            /*
             -- 两个参数为Nil表示默认扫描所有可见蓝牙设备。
             -- 注意：第一个参数是用来扫描有指定服务的外设。然后有些外设的服务是相同的，比如都有FFF5服务，那么都会发现；而有些外设的服务是不可见的，就会扫描不到设备。
             -- 成功扫描到外设后调用didDiscoverPeripheral
             */
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        }
            break;
        default:
            break;
    }
}

//发现外部设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (![peripheral name]) {
        return;
    }
    NSLog(@"Find device:%@", [peripheral name]);
    
    if ([peripheral.name containsString:@"DIALOG_TEST_"]) {
        _peripheral = peripheral;
        [self connectDeviceWithPeripheral:_peripheral];
        
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(saveTemData) userInfo:nil repeats:YES];
        [_myTimer fire];
    }
    
}

#pragma mark 连接外设 成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [central stopScan];
    _peripheral.delegate = self;

    [_peripheral discoverServices:@[[CBUUID UUIDWithString:@"EDFEC62E-9910-0BAC-5241-D8BDA6932A2F"]]];
    
    NSLog(@"连接外设 成功");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(connectDeviceSuccess)]) {
        [self.delegate connectDeviceSuccess];
    }
}

#pragma mark 连接外设——失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"%@", error);
}

//断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"%@已断开", peripheral);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TWJDeviceDisContectValueNotification object:nil];
}

#pragma mark 获得外围设备的服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    for (CBService *service in peripheral.services)
    {
        
        NSLog(@"服务%@",service.UUID);
        
        //找到你需要的servicesuuid
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"EDFEC62E-9910-0BAC-5241-D8BDA6932A2F"]])
        {
            //监听它
            [peripheral discoverCharacteristics:nil forService:service];
        }
        
    }
}

#pragma mark 获得服务的特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"15005991-B131-3396-014C-664C9867B917"]]) {//温度

            [peripheral setNotifyValue:YES forCharacteristic:characteristic];

        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"5A87B4EF-3BFA-76A8-E642-92933C31434F"]]) {//灯

        }
        NSLog(@"characteristic:%@",characteristic.UUID);
    }
}

#pragma mark - 获取值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSString *s = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"==== 值：%@ ====",s);
//    s.creatDate = [NSDate date];
    [self.dataArray addObject:s];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TWJReciveTempetureValueNotification object:s userInfo:nil];
}

#pragma mark - 中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else {
        NSLog(@"Notification stopped on %@.  Disconnecting/", characteristic);
        NSLog(@"%@", characteristic);
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}

#pragma mark 数据写入成功回调
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"写入成功");
//    if ([self.delegate respondsToSelector:@selector(didWriteSucessWithStyle:)]) {
//        [self.delegate didWriteSucessWithStyle:_style];
//    }
}

@end
