//
//  NSString+add.m
//  TWJ
//
//  Created by ydd on 2019/8/29.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "NSString+add.h"

static const char *NSStringAddCreatDate = "NSStringAddCreatDate";
@implementation NSString (add)
- (NSDate *)creatDate {
    return objc_getAssociatedObject(self, NSStringAddCreatDate);
}

- (void)setCreatDate:(NSDate * _Nonnull)creatDate {
    objc_setAssociatedObject(self, NSStringAddCreatDate, creatDate, OBJC_ASSOCIATION_RETAIN);
}

+ (NSString *)getCurrentTimestamp
{
    //获取系统当前的时间戳
    NSDate* dat = [NSDate date];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    // 转为字符型
    return timeString;
}

+ (NSString *)timestampFromDate:(NSDate *)date {
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    // 转为字符型
    return timeString;
}

+ (NSString *)timestampChangesDetailTime:(NSString *)timestam {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd  HH:mm:ss"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestam doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (NSString *)getCurrentDateStringWithFormate:(NSString *)formate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:formate];
    NSString *dateString = [df stringFromDate:[NSDate date]];
    return dateString;
}

+(NSString *)getDateStringWithDate:(NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:formate];
    NSString *dateString = [df stringFromDate:date];
    return dateString;
}

@end
