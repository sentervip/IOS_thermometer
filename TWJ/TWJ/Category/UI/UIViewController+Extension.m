

#import "UIViewController+Extension.h"
#import "UINavigationBar+Extension.h"

@implementation UIViewController (Extension)

//STCreate
- (void)setLoginNaviBar{
    
//    [self.navigationController.navigationBar ydy_setBackgroundColor:APP_NAVIBAR_COLOR titleColor:[UIColor whiteColor] titleSize:YDYFONT(18)];
    UIButton * backBtn = [[UIButton alloc] ydy_initLoginBackBtnWithTarget:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
  
    //[self.navigationController.navigationBar ydy_setLineBarColorInLogin:APP_LINEVIEW_COLOR];
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation UINavigationController (ShouldPopOnBackButton)

//监听返回按钮事件
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}


@end
