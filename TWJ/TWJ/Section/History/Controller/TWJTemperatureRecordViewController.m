//
//  TWJTemperatureRecordViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJTemperatureRecordViewController.h"
#import "TWJTemperatureRecordTableViewCell.h"

@interface TWJTemperatureRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UITableView *desTableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TWJTemperatureRecordViewController
#pragma mark get
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor lightGrayColor];
        _headImageView.layer.cornerRadius = 30;
        
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"名字 | 2岁";
        _nameLabel.font = TWJFont(14);
        
    }
    return _nameLabel;
}

- (UITableView *)desTableView {
    if (!_desTableView) {
        _desTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _desTableView.delegate = self;
        _desTableView.dataSource = self;
        _desTableView.scrollEnabled = NO;
        _desTableView.tableFooterView = [UIView new];
    }
    return _desTableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"体温记录";
    
     [self configSubviews];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ | %@岁",self.babyInfo.name,self.babyInfo.age];
    if (self.babyInfo.icon && self.babyInfo.icon.length > 0) {
        NSString *path_document = NSHomeDirectory();
        NSString *namePath = [NSString stringWithFormat:@"/Documents/%@.png",self.babyInfo.icon];
        NSString *imagePath = [path_document stringByAppendingString:namePath];
        self.headImageView.image = [UIImage imageWithContentsOfFile:imagePath] ;
    }else {
        if ([self.babyInfo.sex integerValue] == 1) {
            self.headImageView.image = [UIImage imageNamed:@"defualt_man"];
        }else {
            self.headImageView.image = [UIImage imageNamed:@"defualt_woman"];
        }
    }
    
    for (int i = 0; i < 5; i ++) {
        [self getDatefromDate:[[NSDate date] dateByAddingTimeInterval:- i*24*60*60]];
    }

    [self.desTableView reloadData];
}


- (void)configSubviews {
    [super configSubviews];
    
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.desTableView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(31);
        make.width.height.equalTo(@(60));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.desTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(150);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark date
- (void)getDatefromDate:(NSDate *)date {
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *lastDay = [date dateByAddingTimeInterval:-24*60*60];
    NSString *lasStr = [df2 stringFromDate:lastDay];
    NSString *fromString = [NSString stringWithFormat:@"%@ 23:59:59",lasStr];
    NSDate* fromdate = [df1 dateFromString:fromString];
    NSString *fromTime = [NSString timestampFromDate:fromdate];
    
    NSDate *nextDay = [date dateByAddingTimeInterval:24*60*60];
    NSString *nextStr = [df2 stringFromDate:nextDay];
    NSString *toString = [NSString stringWithFormat:@"%@ 00:00:01",nextStr];
    NSDate* todate = [df1 dateFromString:toString];
    NSString *toTime = [NSString timestampFromDate:todate];
    
    NSArray *arr = [[TWJDataBaseManager sharedInstance] selectHigestTemperatrue:fromTime to:toTime];
    if (arr.count > 0) {
        [self.dataArray addObject:arr[0]];
    }
    
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJTemperatureRecordTableViewCell";
    TWJTemperatureRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJTemperatureRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TWJTemperatureModel *model = self.dataArray[indexPath.row];
    if ([model.temperature floatValue]>38.5) {
        cell.iconImageView.image = [UIImage imageNamed:@"record_highTem"];
    }else {
        cell.iconImageView.image = [UIImage imageNamed:@"record_normalTem"];
    }
    cell.recordLabel.text = [NSString stringWithFormat:@"最高温度%@度",model.temperature];
    cell.timeLabel.text = model.timeString;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
