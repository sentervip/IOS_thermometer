//
//  TWJSelectBabyViewController.h
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHideTabBarViewController.h"
#import "TWJBabyInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TWJSelectBabyViewControllerDelegate <NSObject>

- (void)selectBabyInfo:(TWJBabyInfoModel *)model;

@end


@interface TWJSelectBabyViewController : TWJHideTabBarViewController

@property (nonatomic,assign)id<TWJSelectBabyViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
