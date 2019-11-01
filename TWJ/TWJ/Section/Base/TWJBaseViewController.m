//
//  YDYBaseViewController.m
//  YDYiOS
//
//  Created by fuminghui on 15/9/30.
//  Copyright © 2015年 fuminghui. All rights reserved.
//

#import "TWJBaseViewController.h"
#import "UIButton+Extension.h"

@interface TWJBaseViewController ()

@end

@implementation TWJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
#ifdef DEBUG
    NSLog(@"VC: %@, frame:%@",  NSStringFromClass([self class]),  NSStringFromCGRect(self.view.frame));
#endif
    
    //STModify
//    if (![NSStringFromClass([self class]) isEqualToString:@"YDYDoctorTeamDetailViewController"]) {
//        [self.navigationController.navigationBar ydy_setBackgroundColor:APP_NAVIBAR_COLOR titleColor:[UIColor whiteColor] titleSize:YDYFONT(18)];
//        self.navigationController.navigationBar.backgroundColor = APP_NAVIBAR_COLOR;
//    }

    
    [self configSubviews];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:APP_HEXCOLOR(@"#333333")}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:APP_HEXCOLOR(@"#f6f6f6")] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewDidAppear:(BOOL)animated
{
#ifdef DEBUG
    NSLog(@"VC: %@ -- %@",  NSStringFromClass([self class]), @"viewDidAppear");
#endif
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (NSString *)someViewController {
    if ([NSStringFromClass([self class]) isEqualToString:@"YDYRNViewController" ]) {
        return @"RN健康商城";
    }else if ([NSStringFromClass([self class]) isEqualToString:@"YDYVideoInterrogationViewController" ]) {
        return @"视频问诊";
    }else{
        return self.title;
    }
}

- (void)configSubviews {
    
}

- (void)setChineseNavColor {
    UIColor *color = [UIColor colorWithRed:155/255.0 green:107/255.0 blue:65/255.0 alpha:1.0];
//    [self.navigationController.navigationBar ydy_setBackgroundColor:color titleColor:[UIColor whiteColor] titleSize:YDYFONT(18)];
    self.navigationController.navigationBar.backgroundColor = color;
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc]init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

- (void)showBarButton:(NavigationBarButtonPosition)position title:(NSString *)title fontColor:(UIColor *)color {
    UIButton *button = [[UIButton alloc] initNavigationButtonWithTitle:title color:color];
    [self showBarButton:position button:button];
}

- (void)showBarButton:(NavigationBarButtonPosition)position image:(UIImage *)image {
    _baseButton = [[UIButton alloc] initNavigationButton:image];
    if (position == NavigationBarButtonPositionRight) {
        _baseButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    }
    
    if (position == NavigationBarButtonPositionLeft) {
        _baseButton.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    }
    
    [self showBarButton:position button:_baseButton];
}

- (void)showBarButton:(NavigationBarButtonPosition)position button:(UIButton *)button {
    if (position == NavigationBarButtonPositionLeft) {
        [button addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        //self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    } else if (position == NavigationBarButtonPositionRight) {
        [button addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

- (void)showBarButton:(NavigationBarButtonPosition)position control:(UIControl *)control {
    if (position == NavigationBarButtonPositionLeft) {
        [control addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:control];
        //self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    } else if (position == NavigationBarButtonPositionRight) {
        [control addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:control];
    }
    
    
}

- (void)closeButtonClick{
        self.navigationController.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)openButtonClick{
    self.navigationController.navigationItem.rightBarButtonItem.enabled = YES;
}



- (void)leftButtonTouch {
    [self.navigationController popViewControllerAnimated:YES];
   
}

- (void)rightButtonTouch {
    
}

- (void)addEventHandler{
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#ifdef DEBUG
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
#endif
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
#ifdef DEBUG
    NSLog(@"VC: %@ -- %@",  NSStringFromClass([self class]), @"didReceiveMemoryWarning");
#endif
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


@interface YDYBaseTableViewController ()

@end

@implementation YDYBaseTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self configSubviews];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)configSubviews {
    
}

- (void)showBarButton:(NavigationBarButtonPosition)position title:(NSString *)title fontColor:(UIColor *)color {
    UIButton *button = [[UIButton alloc] initNavigationButtonWithTitle:title color:color];
    [self showBarButton:position button:button];
}

- (void)showBarButton:(NavigationBarButtonPosition)position image:(UIImage *)image {
    UIButton *button = [[UIButton alloc] initNavigationButton:image];
    [self showBarButton:position button:button];
}

- (void)showBarButton:(NavigationBarButtonPosition)position button:(UIButton *)button {
    if (position == NavigationBarButtonPositionLeft) {
        [button addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        //self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    } else if (position == NavigationBarButtonPositionRight) {
        [button addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

- (void)showBarButton:(NavigationBarButtonPosition)position control:(UIControl *)control {
    if (position == NavigationBarButtonPositionLeft) {
        [control addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:control];
        //self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    } else if (position == NavigationBarButtonPositionRight) {
        [control addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:control];
    }
}



- (void)leftButtonTouch {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonTouch {
    
}


- (void)addEventHandler{
    
}

- (void)dealloc {
    
    
}



@end
