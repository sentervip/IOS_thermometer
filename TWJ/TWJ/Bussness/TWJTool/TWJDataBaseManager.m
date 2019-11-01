//
//  FCDataBaseManager.m
//  Meitong
//
//  Created by ydd on 2019/3/18.
//  Copyright © 2019年 zlx. All rights reserved.
//

#define TWJBabyInfoTable @"TWJBabyInfoTable"
#define TWJTemperatureTable @"TWJTemperatureTable"

#import "TWJDataBaseManager.h"
@interface TWJDataBaseManager ()
@property(nonatomic,strong)FMDatabase *database;

@end

@implementation TWJDataBaseManager

+ (instancetype)sharedInstance {
    static TWJDataBaseManager *dataBaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBaseManager = [[super allocWithZone:NULL] init];
    });
    
    return dataBaseManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [TWJDataBaseManager sharedInstance];
}

- (id)init {
    self = [super init];
    if (!self) return nil;
    [self creatDataBaseTable];
    BOOL isH = [[NSUserDefaults standardUserDefaults] boolForKey:TWJIsHuaShiDuKey];
    if (isH) {
        self.isHusShiDu = YES;
    }else {
        self.isHusShiDu = NO;
    }
    return self;
}

- (void)creatDataBaseTable {
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"TWJ.sqlite"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        FMDatabase *db=[FMDatabase databaseWithPath:fileName];
        self.database = db;
        
        [self creatTable];
    }else {
        FMDatabase *db=[FMDatabase databaseWithPath:fileName];
        self.database = db;
    }
    
}

- (void)creatTable {
    if ([self.database open]) {
        //创表 宝贝信息
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age text NOT NULL, sex text NOT NULL, isCe text NOT NULL, icon text NOT NULL)",TWJBabyInfoTable];
        BOOL result=[self.database executeUpdate:sqlStr];
        if (result) {
            NSLog(@"创表成功");
        }else {
            NSLog(@"创表失败");
        }
        
        [self.database close];
    }
    
    //温度
    if ([self.database open]) {
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, temperature text NOT NULL, timeStamp text NOT NULL, babyAddTime text NOT NULL, timeString text NOT NULL)",TWJTemperatureTable];
        BOOL result=[self.database executeUpdate:sqlStr];
        if (result) {
            NSLog(@"创表成功");
        }else {
            NSLog(@"创表失败");
        }
        
        [self.database close];
    }
}

#pragma mark  宝贝信息

- (void)insertBabyinfoWithModel:(TWJBabyInfoModel *)model {
    if (!model) {
        return;
    }
    [self.database open];
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (name, age, sex, isCe, icon) VALUES ('%@', '%@', '%@', '%@', '%@');",TWJBabyInfoTable,model.name,model.age,model.sex,model.isCe,model.icon];
    NSError *error;
    BOOL result = [self.database executeUpdate:sqlStr withErrorAndBindings:&error];
    if (result) {
        
    }else {
        NSLog(@"插入视频记录失败 error:%@",error);
    }
    [self.database close];
}

- (void)deleteBabyinfo {
    [self.database open];
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@",TWJBabyInfoTable];
    BOOL result = [self.database executeUpdate:sqlStr];
    if (result) {
        
    }else {
        NSLog(@"删除失败");
    }
    [self.database close];
}

- (NSArray *)getAllBabyinfo {
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@",TWJBabyInfoTable];
    
    [self.database open];
    FMResultSet *resultSet = [self.database executeQuery:sqlStr];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        TWJBabyInfoModel *model = [TWJBabyInfoModel new];
        model.name = [resultSet stringForColumn:@"name"];
        model.age = [resultSet stringForColumn:@"age"];
        model.sex = [resultSet stringForColumn:@"sex"];
        model.isCe = [resultSet stringForColumn:@"isCe"];
        model.icon = [resultSet stringForColumn:@"icon"];
        [array addObject:model];
    }
    [self.database close];
    return array;
}

- (void)deleteBabyWithModel:(TWJBabyInfoModel *)model {
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where name = '%@' and age = '%@'",TWJBabyInfoTable,model.name,model.age];
    BOOL result = [self.database executeUpdate:sqlStr];
    if (result) {
        
    }else {
        NSLog(@"删除失败");
    }
    [self.database close];
    
}

#pragma mark 温度值

- (void)insertTemperatureWithModel:(TWJTemperatureModel *)model {
    if (!model) {
        return;
    }
    [self.database open];
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (temperature, timeStamp, babyAddTime, timeString) VALUES ('%@', '%@', '%@','%@');",TWJTemperatureTable,model.temperature,model.timeStamp,model.babyAddTime,model.timeString];
    NSError *error;
    BOOL result = [self.database executeUpdate:sqlStr withErrorAndBindings:&error];
    if (result) {
        
    }else {
        NSLog(@"插入温度值失败 error:%@",error);
    }
    [self.database close];
}

-(NSArray *)getTemperatureWithTime:(NSString *)time {
    if (!time) {
        return nil;
    }
    [self.database open];
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ where timeString = '%@' ;",TWJTemperatureTable,time];
    FMResultSet *resultSet = [self.database executeQuery:sqlStr];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        TWJTemperatureModel *model = [TWJTemperatureModel new];
        model.temperature = [resultSet stringForColumn:@"temperature"];
        model.timeStamp = [resultSet stringForColumn:@"timeStamp"];
        model.babyAddTime = [resultSet stringForColumn:@"babyAddTime"];
        model.timeString = [resultSet stringForColumn:@"timeString"];
        [array addObject:model];
    }
    [self.database close];
    return array;
    
}

- (NSArray *)selectHigestTemperatrue:(NSString *)fromTime to:(NSString *)toTime {
    
    [self.database open];
    NSString *sqlStr = [NSString stringWithFormat:@" select * from %@ where temperature = (select max(temperature) from %@ where timeStamp > '%@' and timeStamp < '%@');",TWJTemperatureTable,TWJTemperatureTable,fromTime,toTime];
    FMResultSet *resultSet = [self.database executeQuery:sqlStr];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        TWJTemperatureModel *model = [TWJTemperatureModel new];
        model.temperature = [resultSet stringForColumn:@"temperature"];
        model.timeStamp = [resultSet stringForColumn:@"timeStamp"];
        model.babyAddTime = [resultSet stringForColumn:@"babyAddTime"];
        model.timeString = [resultSet stringForColumn:@"timeString"];
        [array addObject:model];
    }
    [self.database close];
    return array;
}

@end
