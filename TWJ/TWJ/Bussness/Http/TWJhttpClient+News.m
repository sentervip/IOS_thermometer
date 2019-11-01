//
//  TWJhttpClient+News.m
//  TWJ
//
//  Created by ydd on 2019/9/10.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJhttpClient+News.h"

@implementation TWJhttpClient (News)

-(void)requestNews:(NSString *)aPa success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    [[TWJhttpClient sharedClient] postRequestWithURL:@"https://www.apiopen.top/journalismApi" DicWithParamters:nil onSuccess:^(id  _Nonnull responseObject) {
        success(responseObject);
    } onError:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
