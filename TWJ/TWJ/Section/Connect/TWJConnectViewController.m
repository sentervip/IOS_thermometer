//
//  TWJConnectViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/9.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJConnectViewController.h"
#import "TWJBlueToothManager.h"
#import "TWJMainViewController.h"
#import "TWJAddBabyViewController.h"

@interface TWJConnectViewController () <TWJBlueToothManagerDelegate>

@property (nonatomic,strong)UIButton *connectButton;
@property (nonatomic,strong)UILabel  *tipsLabel;
@property (nonatomic,strong)UIImageView *conectImageview;
@property (strong, nonatomic)UIActivityIndicatorView   *actiView;

@end

@implementation TWJConnectViewController
#pragma mark  get
- (UIButton *)connectButton {
    if (!_connectButton) {
        _connectButton = [[UIButton alloc] init];
        [_connectButton setTitle:@"开始搜索" forState:UIControlStateNormal];
        [_connectButton setBackgroundColor:APP_HEXCOLOR(@"#00c9af")];
        [_connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _connectButton.titleLabel.font = TWJFont(17);
        _connectButton.layer.cornerRadius = 22;
        [_connectButton addTarget:self action:@selector(clickConnect:) forControlEvents:UIControlEventTouchDown];
    }
    return _connectButton;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.text = @"启动体温计并打开蓝牙";
        _tipsLabel.font = TWJFont(14);
        _tipsLabel.textColor = APP_HEXCOLOR(@"#999999");
    }
    return _tipsLabel;
}

- (UIImageView *)conectImageview {
    if (!_conectImageview) {
        _conectImageview = [UIImageView new];
        _conectImageview.image = [UIImage imageNamed:@"connect_frame"];
    }
    return _conectImageview;
}

- (UIActivityIndicatorView *)actiView {
    if (!_actiView) {
        _actiView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        _actiView.color = APP_HEXCOLOR(@"#00c9af");
    }
    return _actiView;
    
}

#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"连接体温计";
    
    [self configSubviews];
    
}

#pragma mark UI
- (void)configSubviews {
    [super configSubviews];
    
    [self.view addSubview:self.conectImageview];
    [self.conectImageview addSubview:self.actiView];
    [self.view addSubview:self.connectButton];
    [self.view addSubview:self.tipsLabel];
    
    
    float offset = 64;
    if ([TWJTool isIPhoneX]) {
        offset = [TWJTool topOffsetArea] + 44;
    }
    
    [self.conectImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(112);
        make.width.equalTo(@(184));
        make.height.equalTo(@(265));
    }];
    
    [self.actiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.conectImageview.mas_centerX);
        make.centerY.equalTo(self.conectImageview.mas_centerY);
        make.height.width.equalTo(@(65));
    }];
    
    [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-45);
        make.height.equalTo(@(44));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.connectButton.mas_centerX);
        make.bottom.equalTo(self.connectButton.mas_top).offset(-12);
    }];
}

#pragma mark 点击
- (void)clickConnect:(UIButton *)button {
    [self.actiView startAnimating];
    [TWJBlueToothManager shareManager].delegate = self;
    [[TWJBlueToothManager shareManager] scanDevice];
    
}

- (void)connectDeviceSuccess {
    NSArray *array = [[TWJDataBaseManager sharedInstance] getAllBabyinfo];
    if (array.count > 0) {
        TWJMainViewController *ctrl = [TWJMainViewController new];
        [UIApplication sharedApplication].delegate.window.rootViewController = ctrl;
        [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    }else {
        TWJAddBabyViewController *ctrl = [TWJAddBabyViewController new];
        ctrl.isFromRoot = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

@end
