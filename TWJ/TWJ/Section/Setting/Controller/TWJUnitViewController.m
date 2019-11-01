//
//  TWJUnitViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/24.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJUnitViewController.h"
#import "TWJUnitTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TWJUnitViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *hardwareInfoTableView;
@property (nonatomic,strong)NSIndexPath *selectPath;
@end

@implementation TWJUnitViewController
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

#pragma mark UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.setType == 1) {
        self.navigationItem.title = @"单位设置";
    }else {
        self.navigationItem.title = @"提示音设置";
    }
    
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
    if (self.setType == 1) {
        return 2;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJUnitTableViewCell";
    TWJUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJUnitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if (self.selectPath) {
        if (self.selectPath.row == indexPath.row) {
            cell.selectbutton.selected = YES;
        }else {
            cell.selectbutton.selected = NO;
        }
    }else {
        cell.selectbutton.selected = NO;
    }
    if (self.setType == 1) {
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"摄氏度";
        }else {
            cell.nameLabel.text = @"华氏度";
        }
    }else {
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"默认";
        }else if(indexPath.row == 2){
            cell.nameLabel.text = @"舒缓";
        }else {
            cell.nameLabel.text = @"强烈";
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectPath.row == indexPath.row) {
        return;
    }
    
    self.selectPath = indexPath;
    
    [tableView reloadData];
    
    if (self.setType == 1) {
        if (indexPath.row == 0) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:TWJIsHuaShiDuKey];
            [TWJDataBaseManager sharedInstance].isHusShiDu = NO;
        }else {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TWJIsHuaShiDuKey];
            [TWJDataBaseManager sharedInstance].isHusShiDu = YES;
        }
    }
    
}

@end
