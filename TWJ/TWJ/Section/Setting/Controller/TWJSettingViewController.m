//
//  TWJSettingViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/8.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJSettingViewController.h"
#import "TWJSettingHeaderView.h"
#import "TWJSettingTableViewCell.h"
#import "TWJSelectBabyViewController.h"
#import "TWJHardwareInfoViewController.h"
#import "TWJAboutViewController.h"
#import "TWJUnitViewController.h"
#import "TWJNearHospitalViewController.h"
#import "TWJTemperatureSetViewController.h"
#import "TWJBabyInfoModel.h"

@interface TWJSettingViewController ()<UITableViewDelegate,UITableViewDataSource,TWJSelectBabyViewControllerDelegate>

@property (nonatomic,strong)TWJSettingHeaderView *headerView;

@property (nonatomic,strong)UITableView *settingTableView;

@property (nonatomic,copy)NSArray *titleArray;

@property (nonatomic,copy)NSArray *imageNameArray;

@end

@implementation TWJSettingViewController
#pragma mark get
- (TWJSettingHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TWJSettingHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 100)];
        if ([TWJTool isIPhoneX]) {
            _headerView.frame = CGRectMake(0, 84, KSCREEN_WIDTH, 100);
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeader)];
        tap.numberOfTapsRequired = 1;
        _headerView.userInteractionEnabled = YES;
        [_headerView addGestureRecognizer:tap];
    }
    return _headerView;
}

- (UITableView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] init];
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.tableFooterView = [UIView new];
    }
    return _settingTableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[
//                        @"温度补偿",
                        @"高低温设置",
                        @"提示音设置",
                        @"单位",
                        @"硬件信息",
//                        @"帮助",
                        @"关于",
                        @"附近医院"];
    }
    return _titleArray;
}

- (NSArray *)imageNameArray {
    if (!_imageNameArray) {
        _imageNameArray = @[
//                            @"setting_compensation",
                            @"setting_hightOrLow",
                            @"setting_voice",
                            @"setting_unit",
                            @"setting_hardware",
//                            @"setting_help",
                            @"setting_about",
                            @"setting_nearHos"];
    }
    return _imageNameArray;
}

#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = APP_HEXCOLOR(@"#f6f6f6");
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.settingTableView];
    
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom).offset(14);
    }];
    
    NSArray *array = [[TWJDataBaseManager sharedInstance] getAllBabyinfo];
    if (array.count > 0) {
        TWJBabyInfoModel *model = array[0];
        [self layIconWithModel:model];
    }
    
}

- (void)layIconWithModel:(TWJBabyInfoModel *)model {
    if (model.icon && model.icon.length > 0) {
        NSString *path_document = NSHomeDirectory();
        NSString *namePath = [NSString stringWithFormat:@"/Documents/%@.png",model.icon];
        NSString *imagePath = [path_document stringByAppendingString:namePath];
        self.headerView.headerImageView.image = [UIImage imageWithContentsOfFile:imagePath] ;
    }else {
        if ([model.sex integerValue] == 1) {
            self.headerView.headerImageView.image = [UIImage imageNamed:@"defualt_man"];
        }else {
            self.headerView.headerImageView.image = [UIImage imageNamed:@"defualt_woman"];
        }
    }
    
    self.headerView.nameLabel.text = model.name;
    self.headerView.agelabel.text = [NSString stringWithFormat:@"|  %@",model.age];
}

#pragma mark 点击
- (void)clickHeader {
    TWJSelectBabyViewController *ctrl = [TWJSelectBabyViewController new];
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark TWJSelectBabyViewControllerDelegate
- (void)selectBabyInfo:(TWJBabyInfoModel *)model {
    [self layIconWithModel:model];
}


#pragma mark tableview delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJSettingTableViewCell";
    TWJSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.iconImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    cell.descLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
//        case 0:
//
//            break;
            
        case 0:
        {
            TWJTemperatureSetViewController *ctrl = [TWJTemperatureSetViewController new];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 1:
        {
            TWJUnitViewController *ctrl = [TWJUnitViewController new];
            ctrl.setType = 2;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 2:
        {
            TWJUnitViewController *ctrl = [TWJUnitViewController new];
            ctrl.setType = 1;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 3:
        {
            TWJHardwareInfoViewController *ctrl = [TWJHardwareInfoViewController new];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
//        case 4:
//
//            break;
        case 4:
        {
            TWJAboutViewController *ctrl = [TWJAboutViewController new];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 5:
        {
            TWJNearHospitalViewController *ctrl = [TWJNearHospitalViewController new];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        default:
            break;
    }
    
}

@end
