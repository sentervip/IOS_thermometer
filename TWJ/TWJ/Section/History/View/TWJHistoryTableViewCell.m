//
//  TWJHistoryTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/22.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHistoryTableViewCell.h"

@implementation TWJHistoryTableViewCell

#pragma mark get
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 37/2;
        _headerImageView.layer.masksToBounds = YES;
    }
    return _headerImageView;
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

- (UILabel *)agelabel {
    if (!_agelabel) {
        _agelabel = [UILabel new];
        _agelabel.font = TWJFont(17);
        _agelabel.text = @"|  2岁";
        _agelabel.textColor = APP_HEXCOLOR(@"#333333");
    }
    return _agelabel;
}


#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.headerImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.agelabel];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.height.equalTo(@(37));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(14);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.agelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(12);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
