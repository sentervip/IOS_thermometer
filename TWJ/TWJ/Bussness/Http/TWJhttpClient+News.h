//
//  TWJhttpClient+News.h
//  TWJ
//
//  Created by ydd on 2019/9/10.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJhttpClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWJhttpClient (News)

- (void)requestNews:(NSString *)aPa success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
