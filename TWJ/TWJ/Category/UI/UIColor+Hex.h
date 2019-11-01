//
//  UIColor+Hex.h
//  Meitong
//
//  Created by ydd on 2018/12/3.
//  Copyright © 2018年 zlx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)
+ (UIColor *)fc_colorWithHex:(NSUInteger)hex;

+ (UIColor *)fc_colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)fc_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
