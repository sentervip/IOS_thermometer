//
//  TWJHistoryViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/8.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHistoryViewController.h"
#import "TWJHistoryTableViewCell.h"
#import "TWJTemperatureRecordViewController.h"
#import "TWJBabyInfoModel.h"

@interface TWJHistoryViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *selectBabyTableview;
@property (nonatomic,strong)NSArray *babyListArray;
@end

@implementation TWJHistoryViewController
#pragma mark get
- (UITableView *)selectBabyTableview {
    if (!_selectBabyTableview) {
        _selectBabyTableview = [[UITableView alloc] init];
        _selectBabyTableview.delegate = self;
        _selectBabyTableview.dataSource = self;
        _selectBabyTableview.tableFooterView = [UIView new];
    }
    return _selectBabyTableview;
}


#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"历史记录";
    
    NSArray *array = [[TWJDataBaseManager sharedInstance] getAllBabyinfo];
    self.babyListArray = [[NSArray alloc] initWithArray:array];
    
    [self.view addSubview:self.selectBabyTableview];
    
    [self.selectBabyTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark click

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.babyListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJHistoryTableViewCell";
    TWJHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    TWJBabyInfoModel *model = [self.babyListArray objectAtIndex:indexPath.row];
    if (model.icon && model.icon.length > 0) {
        NSString *path_document = NSHomeDirectory();
        NSString *namePath = [NSString stringWithFormat:@"/Documents/%@.png",model.icon];
        NSString *imagePath = [path_document stringByAppendingString:namePath];
        cell.headerImageView.image = [UIImage imageWithContentsOfFile:imagePath] ;
    }else {
        if ([model.sex integerValue] == 1) {
            cell.headerImageView.image = [UIImage imageNamed:@"defualt_man"];
        }else {
            cell.headerImageView.image = [UIImage imageNamed:@"defualt_woman"];
        }
    }
    
    cell.nameLabel.text = model.name;
    cell.agelabel.text = [NSString stringWithFormat:@"|  %@",model.age];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TWJBabyInfoModel *model = [self.babyListArray objectAtIndex:indexPath.row];
    TWJTemperatureRecordViewController *ctrl = [TWJTemperatureRecordViewController new];
    ctrl.babyInfo = model;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
