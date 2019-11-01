//
//  TWJSettingHeaderView.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJSettingHeaderView.h"

@implementation TWJSettingHeaderView
#pragma mark get
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 30;
        _headerImageView.backgroundColor = [UIColor lightGrayColor];
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
        make.width.height.equalTo(@(60));
        make.top.equalTo(self.mas_top).offset(20);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(12);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.agelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(12);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
