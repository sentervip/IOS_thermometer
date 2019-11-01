//
//  TWJTool.h
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWJTool : NSObject

+ (BOOL)isIPhoneX;

+(NSString*)iphoneType;

+ (float)topOffsetArea;

+ (float)bottomOffsetArea;

@end

NS_ASSUME_NONNULL_END
