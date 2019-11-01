//
//  YDYNavigationViewController.m
//  YDYiOS
//
//  Created by fuminghui on 15/10/8.
//  Copyright © 2015年 fuminghui. All rights reserved.
//

#import "TWJNavigationController.h"
#import "UIViewController+Extension.h"
#import "UIButton+Extension.h"

@interface TWJNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak) UIViewController* currentShowVC;

@end

@implementation TWJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
    
    self.navigationBar.backgroundColor = APP_HEXCOLOR(@"#f6f6f6");
    
    __weak TWJNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
}

- (void)dealloc {
//    [[SDImageCache sharedImageCache] clearDisk];
}

//STCreate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton * backBtn = [[UIButton alloc] ydy_initBackBtnWithTarget:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
    }
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}




- (void)back{
    [self popView];
    //    [self popViewControllerAnimated:YES];
}


- (void)popView{
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self visibleViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }else{
        for(UIView *subview in [self.navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark - 侧滑返回添加 STCreate
//- (id)initWithRootViewController:(UIViewController *)rootViewController {
//    YDYNavigationController* nvc = [super initWithRootViewController:rootViewController];
//    nvc.interactivePopGestureRecognizer.delegate = (id)rootViewController;
//    //nvc.delegate = rootViewController;
//
//    return nvc;
//}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{

//    if (navigationController.viewControllers.count == 1)
//        self.currentShowVC = Nil;
//    else
//        self.currentShowVC = viewController;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

//    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//        return (self.currentShowVC == self.topViewController); //the most important
//    }
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        NSLog(@"%@",NSStringFromClass([self.visibleViewController class]));
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]
            || [NSStringFromClass([self.visibleViewController class]) isEqualToString:@"YDYIMChatViewController"]
            || [NSStringFromClass([self.visibleViewController class]) isEqualToString:@"YDYRNViewController"]
            || [NSStringFromClass([self.visibleViewController class]) isEqualToString:@"YDYInterrogationJudgeViewController"])
            //|| [NSStringFromClass([self.visibleViewController class]) isEqualToString:@"YDYFamouseChineseDoctorDetailViewController"])
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
    {
        return YES;
    }
    else
    {
        return  NO;
    }
}

@end
