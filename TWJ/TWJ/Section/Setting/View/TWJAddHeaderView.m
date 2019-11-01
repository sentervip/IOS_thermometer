//
//  TWJAddHeaderView.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJAddHeaderView.h"

@implementation TWJAddHeaderView
#pragma mark get
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 55/2;
        _headerImageView.backgroundColor = [UIColor lightGrayColor];
        _headerImageView.layer.masksToBounds = YES;
    }
    return _headerImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = TWJFont(17);
        _nameLabel.text = @"头像";
        
    }
    return _nameLabel;
}

- (UIView *)lineview {
    if (!_lineview) {
        _lineview = [UIView new];
        _lineview.backgroundColor = APP_HEXCOLOR(@"#e5e5e5");
    }
    return _lineview;
}

- (UIImageView *)arrowImageview {
    if (!_arrowImageview) {
        _arrowImageview = [[UIImageView alloc] init];
        _arrowImageview.image = [UIImage imageNamed:@"right_arrow"];
    }
    return _arrowImageview;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.headerImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineview];
    [self addSubview:self.arrowImageview];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.arrowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(8));
        make.height.equalTo(@(13));
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageview.mas_left).offset(-10);
        make.width.height.equalTo(@(55));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(0.5));
    }];
}



@end


@implementation TWJAddFooterView

#pragma mark get
- (UISwitch *)footSwitch {
    if (!_footSwitch) {
        _footSwitch = [[UISwitch alloc] init];
    }
    return _footSwitch;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = TWJFont(17);
        _titleLabel.text = @"设为测量宝宝";
        
    }
    return _titleLabel;
}

- (UIView *)lineview {
    if (!_lineview) {
        _lineview = [UIView new];
        _lineview.backgroundColor = APP_HEXCOLOR(@"#e5e5e5");
    }
    return _lineview;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.lineview];
    [self addSubview:self.titleLabel];
    [self addSubview:self.footSwitch];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(0.5));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.footSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
}


@end
