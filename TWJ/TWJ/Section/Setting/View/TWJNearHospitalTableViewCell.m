//
//  TWJNearHospitalTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/25.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJNearHospitalTableViewCell.h"

@implementation TWJNearHospitalTableViewCell
#pragma mark get
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = TWJFont(17);
        _nameLabel.textColor= APP_HEXCOLOR(@"#333333");
    }
    return _nameLabel;
}

- (UILabel *)distancelabel {
    if (!_distancelabel) {
        _distancelabel = [UILabel new];
        _distancelabel.font = TWJFont(13);
        _distancelabel.textColor = APP_HEXCOLOR(@"#666666");
    }
    return _distancelabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = TWJFont(13);
        _addressLabel.textColor = APP_HEXCOLOR(@"#666666");
    }
    return _addressLabel;
}
#pragma mark ui
- (void)commonInit {
    [super commonInit];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.distancelabel];
    [self addSubview:self.addressLabel];
    
    self.lineView.hidden = NO;
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.mas_centerY).offset(-4.5);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
    [self.distancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_centerY).offset(4.5);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.distancelabel.mas_right).offset(10);
        make.top.equalTo(self.mas_centerY).offset(4.5);
    }];
}

@end
