//
//  TWJAddBabyViewController.h
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHideTabBarViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TWJAddBabyViewControllerDelegate <NSObject>

- (void)addBabySuccess;

@end

@interface TWJAddBabyViewController : TWJHideTabBarViewController

@property (nonatomic)BOOL isFromRoot;//跳转来源

@property (nonatomic,assign)id<TWJAddBabyViewControllerDelegate> delegate;

//@property (nonatomic,strong)NSArray *;

@end

NS_ASSUME_NONNULL_END
