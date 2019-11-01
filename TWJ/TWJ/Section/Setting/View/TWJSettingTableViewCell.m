//
//  TWJSettingTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJSettingTableViewCell.h"

@implementation TWJSettingTableViewCell

#pragma mark get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.font = TWJFont(17);
        _descLabel.textColor = APP_HEXCOLOR(@"#333333");
    }
    return _descLabel;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.descLabel];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(22));
        make.width.equalTo(@(21));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(12);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

@end
