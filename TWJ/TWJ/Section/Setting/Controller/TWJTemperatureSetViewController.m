//
//  TWJTemperatureSetViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/25.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJTemperatureSetViewController.h"
#import "TWJTemperatureSetTableViewCell.h"
#import "ZZPickView.h"

@interface TWJTemperatureSetViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *hardwareInfoTableView;
@property (nonatomic,strong)ZZPickView *pickView;

@property (nonatomic,strong)NSArray *pickArray1;
@property (nonatomic,strong)NSArray *pickArray2;

@property (nonatomic,strong)NSString *hightString;
@property (nonatomic,strong)NSString *lowString;
@end

@implementation TWJTemperatureSetViewController
#pragma mark get
- (UITableView *)hardwareInfoTableView {
    if (!_hardwareInfoTableView) {
        _hardwareInfoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _hardwareInfoTableView.delegate = self;
        _hardwareInfoTableView.dataSource = self;
        _hardwareInfoTableView.tableFooterView = [UIView new];
        _hardwareInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hardwareInfoTableView.scrollEnabled = NO;
    }
    return _hardwareInfoTableView;
}

-(ZZPickView *)pickView
{
    if (_pickView==nil) {
        _pickView= [[ZZPickView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
        [self.view.window addSubview:_pickView];
    }
    return _pickView;
}

- (NSArray *)pickArray1 {
    if (!_pickArray1) {
        _pickArray1 = @[@""];
    }
    return _pickArray1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"高低温设置";
    
    NSString *hight = [[NSUserDefaults standardUserDefaults] objectForKey:TWJHightTempretrueKey];
    if (hight) {
        self.hightString = hight;
    }else {
        self.hightString = @"";
    }
    
    NSString *low = [[NSUserDefaults standardUserDefaults] objectForKey:TWJLowTempretrueKey];
    if (low) {
        self.lowString = low;
    }else {
        self.lowString = @"";
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJTemperatureSetTableViewCell";
    TWJTemperatureSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJTemperatureSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.iconImageView.image = [UIImage imageNamed:@"high_waring"];
        cell.nameLabel.text = @"高温报警值";
        cell.contentlabel.text = [NSString stringWithFormat:@"%@%@",self.hightString,TWJSheShiDuSymbol];
    }else {
        cell.iconImageView.image = [UIImage imageNamed:@"low_waring"];
        cell.nameLabel.text = @"低温报警值";
        cell.contentlabel.text = [NSString stringWithFormat:@"%@%@",self.lowString,TWJSheShiDuSymbol];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.pickView.seleIndex removeAllObjects];
    [self.pickView.seleIndex addObject:@"5"];
    [self.pickView.seleIndex addObject:@"5"];
    
    self.pickView.dataSource = @[@[@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42"],@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];

    if (indexPath.row == 0) {
        self.pickView.title=@"宝宝体温高于此温度将会提醒您";
    }else {
        self.pickView.title=@"宝宝体温低于此温度将会提醒您";
    }
    __weak typeof(self) weakself = self;
    self.pickView.action = ^(NSString *title){
        NSLog(@"selecttitle:%@",title);
        __strong typeof(weakself) strongself = weakself;
        if (indexPath.row == 0) {
            if ([title floatValue] < [strongself.lowString floatValue]) {
                [SVProgressHUD showInfoWithStatus:@"高温设置值需大于低温值"];
            }else {
                strongself.hightString = title;
                [strongself.hardwareInfoTableView reloadData];
                [[NSUserDefaults standardUserDefaults] setObject:title forKey:TWJHightTempretrueKey];
            }
            
        }else {
            if ([title floatValue] > [strongself.hightString floatValue] && strongself.hightString.length > 0) {
                [SVProgressHUD showInfoWithStatus:@"低温设置值需小于高温值"];
                
            }else {
                strongself.hightString = title;
                [strongself.hardwareInfoTableView reloadData];
                [[NSUserDefaults standardUserDefaults] setObject:title forKey:TWJLowTempretrueKey];
                
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:TWJTempetureSettingValueNotification object:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    };
    [self.pickView show];
}

@end
