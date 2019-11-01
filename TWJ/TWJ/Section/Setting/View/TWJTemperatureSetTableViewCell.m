//
//  TWJTemperatureSetTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/25.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJTemperatureSetTableViewCell.h"

@implementation TWJTemperatureSetTableViewCell

#pragma mark get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 15;
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = TWJFont(17);
        _nameLabel.text = @"name";
        _nameLabel.textColor = APP_HEXCOLOR(@"#333333");
    }
    return _nameLabel;
}

- (UILabel *)contentlabel {
    if (!_contentlabel) {
        _contentlabel = [UILabel new];
        _contentlabel.font = TWJFont(14);
        _contentlabel.text = @"|  2岁";
        _contentlabel.textColor = APP_HEXCOLOR(@"#999999");
    }
    return _contentlabel;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentlabel];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.width.height.equalTo(@(22));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-38);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
