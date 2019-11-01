//
//  TWJhttpClient.m
//  TWJ
//
//  Created by ydd on 2019/9/10.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJhttpClient.h"

@implementation TWJhttpClient

+ (TWJhttpClient *)sharedClient
{
    static TWJhttpClient * sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[super allocWithZone:NULL] init];
    });
    return sharedClient;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    
    return [TWJhttpClient sharedClient];
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [TWJhttpClient sharedClient];
}

- (void)postRequestWithURL:(NSString *)url DicWithParamters:(NSDictionary *)paramters onSuccess:(void (^)(id _Nonnull))succBlck onError:(void (^)(NSError * _Nonnull))errorBlock {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    manager.requestSerializer.timeoutInterval = 30;
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succBlck(responseObject);
        NSHTTPURLResponse *responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode>=500) {
//            APP_LOAD_END;
//            APP_HUD(@"服务器维护中，请稍后重试");
            //[YDYHubView showWithInfo:@"服务器维护中，请稍后重试"];
        }
        NSLog(@"%ld",(long)(responses.statusCode));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)3*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            errorBlock(error);
        });
//        if (error.code == -1001) {
////            APP_HUD(@"网络连接超时，请稍后重试");
//        }else if (error.code == -1009){
////            if (!_isReported) {
////                _isReported = YES;
////                if (![YDYClient sharedClient].is3G4G && ![YDYClient sharedClient].isWifi)  {
////                    APP_HUD(@"网络貌似不给力，请检查您的网络设置");
////                    //[YDYHubView showWithInfo:@"网络貌似不给力～请检查您的网络后重试"];
////                }else{
////                    APP_HUD(@"服务器维护中，请稍后重试");
////                }
////            }
//        }else{
//            // errorBlock(error);
//        }
    }];
}

@end
