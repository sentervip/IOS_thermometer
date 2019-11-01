//
//  NSString+add.h
//  TWJ
//
//  Created by ydd on 2019/8/29.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (add)

@property (nonatomic,strong,readwrite)NSDate *creatDate;
/**
*  获取当前时间的时间戳（例子：1464326536）
*
*  @return 时间戳字符串型
*/
+ (NSString *)getCurrentTimestamp;

//时间转时间戳
+(NSString *)timestampFromDate:(NSDate *)date ;

/**
 时间戳转时间

 @param timestam 时间戳
        format  时间格式
 @return 时间
 */
+ (NSString *)timestampChangesDetailTime:(NSString *)timestam ;

+ (NSString *)getCurrentDateStringWithFormate:(NSString *)formate;


+ (NSString *)getDateStringWithDate:(NSDate *)date formate:(NSString *)formate;

@end

NS_ASSUME_NONNULL_END
