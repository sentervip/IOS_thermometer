//
//  YDYBaseViewController.h
//  YDYiOS
//
//  Created by fuminghui on 15/9/30.
//  Copyright © 2015年 fuminghui. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YDYBackgroundView.h"

typedef NS_ENUM(NSInteger, NavigationBarButtonPosition) {
    NavigationBarButtonPositionLeft = 0,
    NavigationBarButtonPositionRight = 1,
};

/**
 控制器基类
 */
@interface TWJBaseViewController : UIViewController

//@property (nonatomic, strong) YDYBackgroundView * errorView;//网络异常

@property (nonatomic, strong) UIButton * baseButton;

- (void)configSubviews __attribute((objc_requires_super));

- (void)addEventHandler;

- (void)showBarButton:(NavigationBarButtonPosition)position title:(NSString *)title fontColor:(UIColor *)color;
- (void)showBarButton:(NavigationBarButtonPosition)position image:(UIImage *)image;
- (void)showBarButton:(NavigationBarButtonPosition)position button:(UIButton *)button;
- (void)showBarButton:(NavigationBarButtonPosition)position control:(UIControl *)control;
- (void)leftButtonTouch;
- (void)rightButtonTouch;
- (void)closeButtonClick;
- (void)openButtonClick;

- (void)setChineseNavColor;//设置中医主题颜色

@end



@interface YDYBaseTableViewController :UITableViewController


- (void)configSubviews;

- (void)addEventHandler;

- (void)showBarButton:(NavigationBarButtonPosition)position title:(NSString *)title fontColor:(UIColor *)color;
- (void)showBarButton:(NavigationBarButtonPosition)position image:(UIImage *)image;
- (void)showBarButton:(NavigationBarButtonPosition)position button:(UIButton *)button;
- (void)showBarButton:(NavigationBarButtonPosition)position control:(UIControl *)control;
- (void)leftButtonTouch;
- (void)rightButtonTouch;

@end


