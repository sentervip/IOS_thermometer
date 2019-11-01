//
//  TWJAboutViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/22.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJAboutViewController.h"
#import "TWJHardwareInfoTableViewCell.h"

@interface TWJAboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *versionLabel;
@property (nonatomic,strong)UITableView *tableview;

@end

@implementation TWJAboutViewController
#pragma mark get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"about_icon"];
    }
    return _iconImageView;
}

- (UILabel *)versionLabel {
    if (!_versionLabel) {
        _versionLabel = [UILabel new];
        _versionLabel.textColor = APP_HEXCOLOR(@"#333333");
        _versionLabel.text = @"版本号：";
    }
    return _versionLabel;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    
    [self configSubviews];
}

- (void)configSubviews {
    [super configSubviews];
    
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.tableview];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(45);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(14);
    }];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(200);
    }];
}


#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"wareInfoTableViewCell";
    TWJHardwareInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJHardwareInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.titlelabel.text = @"隐私协议";
    }else {
        cell.titlelabel.text = @"安全要求及注意事项";
    }
    
    cell.contentlabel.hidden = YES;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
@end
