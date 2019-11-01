//
//  TWJNearHospitalInfoModel.h
//  TWJ
//
//  Created by ydd on 2019/7/25.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWJNearHospitalInfoModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)double distance;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)id mapitem;

@end

NS_ASSUME_NONNULL_END
