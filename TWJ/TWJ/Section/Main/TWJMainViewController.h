//
//  TWJMainViewController.h
//  TWJ
//
//  Created by ydd on 2019/7/8.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWJHomeViewController.h"
#import "TWJHistoryViewController.h"
#import "TWJSettingViewController.h"
#import "TWJNewsViewController.h"
#import "TWJNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWJMainViewController : UITabBarController

@property (strong, nonatomic) TWJHomeViewController * homeViewController;
@property (strong, nonatomic) TWJHistoryViewController * historyViewController;
@property (strong, nonatomic) TWJSettingViewController * settingViewController;
@property (strong, nonatomic) TWJNewsViewController * newsViewController;

@property (strong, nonatomic) TWJNavigationController * homeNavigationController;
@property (strong, nonatomic) TWJNavigationController * historyNavigationController;
@property (strong, nonatomic) TWJNavigationController * settingNavigationController;
@property (strong, nonatomic) TWJNavigationController * newsNavigationController;



@end

NS_ASSUME_NONNULL_END
