//
//  TWJHardwareInfoViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/24.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHardwareInfoViewController.h"
#import "TWJHardwareInfoTableViewCell.h"

@interface TWJHardwareInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *hardwareInfoTableView;

@property (nonatomic,copy)NSArray *titleArray;

@end

@implementation TWJHardwareInfoViewController

#pragma mark get
- (UITableView *)hardwareInfoTableView {
    if (!_hardwareInfoTableView) {
        _hardwareInfoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _hardwareInfoTableView.delegate = self;
        _hardwareInfoTableView.dataSource = self;
        _hardwareInfoTableView.tableFooterView = [UIView new];
        _hardwareInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _hardwareInfoTableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"智能测ID",@"蓝牙信号强度",@"硬件版本",@"固件版本",@"MAC地址",@"智能测ID",@"智能测ID"];
    }
    return _titleArray;
}

#pragma mark UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"硬件信息";
    
    [self configSubviews];
}

- (void)configSubviews {
    [super configSubviews];
    
    [self.view addSubview:self.hardwareInfoTableView];
    
    [self.hardwareInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJHardwareInfoTableViewCell";
    TWJHardwareInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJHardwareInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.titlelabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.contentlabel.text = @"1A经济";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

@end
