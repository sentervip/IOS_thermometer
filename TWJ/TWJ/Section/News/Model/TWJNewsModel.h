//
//  TWJNewsModel.h
//  TWJ
//
//  Created by ydd on 2019/9/10.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWJNewsModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *digest;
@property (nonatomic,strong)NSString *link;
@property (nonatomic,strong)NSArray *picInfo;

@end

NS_ASSUME_NONNULL_END
