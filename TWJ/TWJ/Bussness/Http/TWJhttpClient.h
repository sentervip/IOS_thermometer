//
//  TWJhttpClient.h
//  TWJ
//
//  Created by ydd on 2019/9/10.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWJhttpClient : NSObject
+ (TWJhttpClient *)sharedClient;


- (void)postRequestWithURL:(NSString *)url
          DicWithParamters:(NSDictionary *)paramters
                 onSuccess:(void(^)(id responseObject))succBlck
                   onError:(void(^)(NSError *error))errorBlock;

@end

NS_ASSUME_NONNULL_END
