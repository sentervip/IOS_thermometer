//
//  TWJBabyInfoModel.h
//  TWJ
//
//  Created by ydd on 2019/8/13.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWJBabyInfoModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *age;
@property (nonatomic,copy)NSString *sex;//1男  0女
@property (nonatomic,copy)NSString *isCe;//是否是测量宝宝 1是，0不是
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *addTime;//yyyy-MM-dd HH:mm:ss

@end

NS_ASSUME_NONNULL_END
