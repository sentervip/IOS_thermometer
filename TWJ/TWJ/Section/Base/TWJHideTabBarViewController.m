//
//  YDYHideTabBarViewController.m
//  YDYiOS
//
//  Created by fuminghui on 15/9/30.
//  Copyright © 2015年 fuminghui. All rights reserved.
//

#import "TWJHideTabBarViewController.h"


@interface TWJHideTabBarViewController ()<UIGestureRecognizerDelegate>

@end

@implementation TWJHideTabBarViewController

- (id)init{
    self = [super init];
    if (!self) return nil;
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeBottom;
    
}



//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//
////    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
////        return (self.currentShowVC == self.topViewController); //the most important
////    }
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
//        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
//    {
//        return YES;
//    }
//    else
//    {
//        return  NO;
//    }
//}

@end

