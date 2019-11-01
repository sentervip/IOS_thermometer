//
//  TWJMainViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/8.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJMainViewController.h"

@interface TWJMainViewController ()

@end

@implementation TWJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllers  = @[self.homeNavigationController,self.historyNavigationController, self.newsNavigationController,self.settingNavigationController];
    self.selectedViewController = self.homeNavigationController;
}

#pragma mark - getter or setter
- (UINavigationController *)homeNavigationController
{
    if (!_homeNavigationController) {
        _homeNavigationController = [[TWJNavigationController alloc] initWithRootViewController:self.homeViewController];
        _homeNavigationController.tabBarItem.title = @"首页";
        [_homeNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#00c9af"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [_homeNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#666666"),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        _homeNavigationController.tabBarItem.image = [UIImage imageNamed:@"tab_home_normal"];
        UIImage *selectedImage = [UIImage imageNamed:@"tab_home_pressed"];
        _homeNavigationController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _homeNavigationController;
}



- (TWJHomeViewController *)homeViewController
{
    if (!_homeViewController) {
        _homeViewController = [TWJHomeViewController new];
        _homeViewController.tabBarItem.title = @"首页";
    }
    return _homeViewController;
}

- (TWJNavigationController *)historyNavigationController
{
    if (!_historyNavigationController) {
        _historyNavigationController = [[TWJNavigationController alloc] initWithRootViewController:self.historyViewController];
        _historyNavigationController.tabBarItem.title = @"历史记录";
        [_historyNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#00c9af"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [_historyNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#666666"),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        _historyNavigationController.tabBarItem.image = [UIImage imageNamed:@"tab_history_normal"];
        UIImage *selectedImage = [UIImage imageNamed:@"tab_history_pressed"];
        _historyNavigationController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _historyNavigationController;
}



- (TWJHistoryViewController *)historyViewController
{
    if (!_historyViewController) {
        _historyViewController = [TWJHistoryViewController new];
//        _historyViewController.tabBarItem.title = @"历史";
    }
    return _historyViewController;
}


- (TWJNavigationController *)newsNavigationController
{
    if (!_newsNavigationController) {
        _newsNavigationController = [[TWJNavigationController alloc] initWithRootViewController:self.newsViewController];
        _newsNavigationController.tabBarItem.title = @"育儿知识";
        [_newsNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#00c9af"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [_newsNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#666666"),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        _newsNavigationController.tabBarItem.image = [UIImage imageNamed:@"tab_news_normal"];
        UIImage *selectedImage = [UIImage imageNamed:@"tab_news_pressed"];
        _newsNavigationController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _newsNavigationController;
}



- (TWJNewsViewController *)newsViewController
{
    if (!_newsViewController) {
        _newsViewController = [TWJNewsViewController new];
        _newsViewController.tabBarItem.title = @"育儿知识";
    }
    return _newsViewController;
}

- (TWJNavigationController *)settingNavigationController
{
    if (!_settingNavigationController) {
        _settingNavigationController = [[TWJNavigationController alloc] initWithRootViewController:self.settingViewController];
        _settingNavigationController.tabBarItem.title = @"设置";
        [_settingNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#00c9af"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [_settingNavigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_HEXCOLOR(@"#666666"),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        _settingNavigationController.tabBarItem.image = [UIImage imageNamed:@"tab_setting_normal"];
        UIImage *selectedImage = [UIImage imageNamed:@"tab_setting_pressed"];
        _settingNavigationController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _settingNavigationController;
}



- (TWJSettingViewController *)settingViewController
{
    if (!_settingViewController) {
        _settingViewController = [TWJSettingViewController new];
        _settingViewController.tabBarItem.title = @"设置";
    }
    return _settingViewController;
}
@end
