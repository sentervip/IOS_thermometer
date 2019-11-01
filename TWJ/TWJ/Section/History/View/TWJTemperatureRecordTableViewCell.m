//
//  TWJTemperatureRecordTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJTemperatureRecordTableViewCell.h"

@implementation TWJTemperatureRecordTableViewCell
#pragma mark get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)recordLabel {
    if (!_recordLabel) {
        _recordLabel = [UILabel new];
        _recordLabel.font = TWJFont(14);
        _recordLabel.text = @"最高温度38度";
        
    }
    return _recordLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = TWJFont(12);
        _timeLabel.text = @"10月2号";
    }
    return _timeLabel;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.recordLabel];
    [self addSubview:self.timeLabel];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.height.equalTo(@(18));
        make.top.equalTo(self.mas_top).offset(5);
    }];
    
    [self.recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(self.iconImageView.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recordLabel.mas_left);
        make.top.equalTo(self.recordLabel.mas_bottom).offset(5);
    }];
}


@end
