//
//  TWJHomeBrokenLineView.m
//  TWJ
//
//  Created by ydd on 2019/7/15.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHomeBrokenLineView.h"
#import "TWJHomeBrokenTableViewCell.h"

@interface TWJHomeBrokenLineView ()
@property (nonatomic,copy)NSArray *selectTextArray;
@property (nonatomic,copy)NSString *selectTimestring;
@end

@implementation TWJHomeBrokenLineView 
#pragma mark get
- (NSArray *)selectTextArray {
    if (!_selectTextArray) {
        _selectTextArray = @[TWJTimeInterval5min,TWJTimeInterval15min,TWJTimeInterval30min,TWJTimeInterval1h,TWJTimeInterval12h];
    }
    return _selectTextArray;
}

- (UILabel *)highestTemLabel {
    if (!_highestTemLabel) {
        _highestTemLabel = [UILabel new];
        _highestTemLabel.font = TWJFont(14);
        _highestTemLabel.textColor = APP_HEXCOLOR(@"#ff776d");
        _highestTemLabel.text = @"最高温度：";
    }
    return _highestTemLabel;
}

- (UIButton *)selectTimeButton {
    if (!_selectTimeButton) {
        _selectTimeButton = [[UIButton alloc] init];
        _selectTimeButton.layer.cornerRadius = 4;
        _selectTimeButton.layer.borderWidth = 1;
        _selectTimeButton.layer.borderColor = APP_HEXCOLOR(@"#999999").CGColor;
        [_selectTimeButton setAttributedTitle:[self getSelectTimeTitle:@"2s"] forState:UIControlStateNormal];
        [_selectTimeButton addTarget:self action:@selector(clickSelectTime:) forControlEvents:UIControlEventTouchDown];
//        _selectTimeButton.userInteractionEnabled = NO;
    }
    return _selectTimeButton;
}


- (TWJDrawChartView *)drawChartView {
    if (!_drawChartView) {
        _drawChartView = [[TWJDrawChartView alloc] initWithFrame:CGRectMake(15, 32, KSCREEN_WIDTH-20, 255)];
        if ([[TWJTool iphoneType] isEqualToString:@"iPhone SE"] || [[TWJTool iphoneType] containsString:@"iPhone 5"]) {
            _drawChartView.frame = CGRectMake(15, 22, KSCREEN_WIDTH-20, 200);
        }
    }
    return _drawChartView;
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH-62-15, 62.5, 62, 182) style:UITableViewStylePlain];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _selectTableView.layer.cornerRadius = 4;
        _selectTableView.layer.borderWidth = 1;
        _selectTableView.layer.borderColor = APP_HEXCOLOR(@"#999999").CGColor;
        _selectTableView.hidden = YES;
    }
    return _selectTableView;
}

#pragma mark ui
- (void)commonInit {
    [super commonInit];
    self.selectTimestring = @"5m";
    
    [self addSubview:self.drawChartView];
    
    [self.drawChartView drawZheXianTu:@[@"00:37:00", @"00:37:30", @"00:38:00", @"00:38:30"] and:@[@"37.5", @"38.0", @"36.5", @"37.0", @"35.8", @"36.2", @"36.8"]];
    
    [self addSubview:self.highestTemLabel];
    [self addSubview:self.selectTimeButton];
    [self addSubview:self.selectTableView];
    [self bringSubviewToFront:self.selectTableView];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.highestTemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(20);
        make.height.equalTo(@(30));
    }];
    
    [self.selectTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.equalTo(@(62));
        make.height.equalTo(@(30));
    }];
    
}

- (NSAttributedString *)getSelectTimeTitle:(NSString *)title {
    NSString *costomtitle = [NSString stringWithFormat:@"%@  ",title];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:costomtitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [attString addAttribute:NSForegroundColorAttributeName value:APP_HEXCOLOR(@"#00c9af") range:NSMakeRange(0, title.length)];

    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"selectTime_arrow"];
    attch.bounds = CGRectMake(0, 2, 7, 4);
    
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:attch] ;
    [attString appendAttributedString:textAttachmentString];
    
    return attString;
}



#pragma mark click
- (void)clickSelectTime:(UIButton *)button {
    self.selectTableView.hidden = !self.selectTableView.hidden;
    
}

- (void)updateLine:(NSArray *)xarray yArray:(NSArray *)yArray {
    [self.drawChartView updatezhexianX:xarray];
    [self.drawChartView updatezhexianY:yArray];
}

#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectTextArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJHomeBrokenTableViewCell";
    TWJHomeBrokenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJHomeBrokenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *time =  self.selectTextArray[indexPath.row];
    cell.selecTimeLabel.text = time;
    
    if ([time isEqualToString:self.selectTimestring]) {
        cell.selecTimeLabel.textColor = APP_HEXCOLOR(@"#00c9af");
    }else {
        cell.selecTimeLabel.textColor = APP_HEXCOLOR(@"#666666");
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:indexPath];
    
    self.selectTableView.hidden = YES;
    [_selectTimeButton setAttributedTitle:[self getSelectTimeTitle:self.selectTextArray[indexPath.row]] forState:UIControlStateNormal];
    self.selectTimestring = self.selectTextArray[indexPath.row];
    [self.selectTableView reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectTimeInterval:)]) {
        [self.delegate selectTimeInterval:self.selectTimestring];
    }
}

@end
