//
//  TWJAddbabyTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJAddbabyTableViewCell.h"

@implementation TWJAddbabyTableViewCell
#pragma mark get
- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
        _titlelabel.font = TWJFont(14);
    }
    return _titlelabel;
}

- (UILabel *)starLabel {
    if (!_starLabel) {
        _starLabel = [UILabel new];
        _starLabel.font = TWJFont(14);
        _starLabel.text = @"*";
        _starLabel.textColor = [UIColor redColor];
    }
    return _starLabel;
}

- (UITextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [UITextField new];
        _contentTextField.font = TWJFont(14);
    }
    return _contentTextField;
}

- (UIImageView *)arrowImageview {
    if (!_arrowImageview) {
        _arrowImageview = [[UIImageView alloc] init];
        _arrowImageview.image = [UIImage imageNamed:@"right_arrow"];
    }
    return _arrowImageview;
}

#pragma mark ui
- (void)commonInit {
    [super commonInit];
    
    [self addSubview:self.titlelabel];
    [self addSubview:self.starLabel];
    [self addSubview:self.arrowImageview];
    [self addSubview:self.contentTextField];
    
    self.lineView.hidden = NO;
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(38));
    }];
    
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlelabel.mas_right).offset(2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.arrowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(8));
        make.height.equalTo(@(13));
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(80);
        make.height.equalTo(@(38));
        make.right.equalTo(self.arrowImageview.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(0.5));
    }];
}

@end
