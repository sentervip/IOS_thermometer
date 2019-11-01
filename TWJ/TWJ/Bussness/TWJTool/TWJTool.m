//
//  TWJTool.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJTool.h"
#import <sys/utsname.h>

@implementation TWJTool

+ (BOOL)isIPhoneX {
    if (@available(iOS 11.0, *)) {
        UIWindow *widon = [UIApplication sharedApplication].delegate.window;
        if (widon.safeAreaInsets.bottom > 0) {
            return YES;
        }else {
            return NO;
        }
    }else{
        return NO;
    }
    
}

+(NSString*)iphoneType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone5,1"]) {
        return @"iPhone 5";
    }
    if ([platform isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    }
    if ([platform isEqualToString:@"iPhone5,3"]) {
        return @"iPhone 5c";
    }
    if ([platform isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c";
    }
    if ([platform isEqualToString:@"iPhone6,1"]) {
        return @"iPhone 5s";
    }
    if ([platform isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s";
    }
    if ([platform isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    }
    if ([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }
    if ([platform isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    }
    if ([platform isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    }
    if ([platform isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    }
    if ([platform isEqualToString:@"iPhone9,1"]) {
        return @"iPhone 7";
    }
    if ([platform isEqualToString:@"iPhone9,2"]) {
        return @"iPhone 7 Plus";
    }
    if ([platform isEqualToString:@"iPhone10,1"]) {
        return @"iPhone 8";
    }
    if ([platform isEqualToString:@"iPhone10,4"]) {
        return @"iPhone 8";
    }
    if ([platform isEqualToString:@"iPhone10,2"]) {
        return @"iPhone 8 Plus";
    }
    if ([platform isEqualToString:@"iPhone10,5"]) {
        return @"iPhone 8 Plus";
    }
    if ([platform isEqualToString:@"iPhone10,3"]) {
        return @"iPhone X";
    }
    if ([platform isEqualToString:@"iPhone10,6"]) {
        return @"iPhone X";
    }
    if ([platform isEqualToString:@"i386"]) {
        return @"iPhone Simulator";
    }
    if ([platform isEqualToString:@"x86_64"]) {
        return @"iPhone Simulator";
    }
    return platform;
}

+ (float)topOffsetArea {
    if (@available(iOS 11.0, *)) {
        UIWindow *widon = [UIApplication sharedApplication].delegate.window;
        return  widon.safeAreaInsets.top;
    }else{
        return 20;
    }
    
}

+(float)bottomOffsetArea {
    if (@available(iOS 11.0, *)) {
        UIWindow *widon = [UIApplication sharedApplication].delegate.window;
        return  widon.safeAreaInsets.bottom;
    }else{
        return 0;
    }
}
@end
