//
//  TWJHardwareInfoTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/24.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHardwareInfoTableViewCell.h"

@implementation TWJHardwareInfoTableViewCell

#pragma mark get
- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
        _titlelabel.font = TWJFont(17);
        _titlelabel.textColor = APP_HEXCOLOR(@"#333333");
    }
    return _titlelabel;
}

- (UILabel *)contentlabel {
    if (!_contentlabel) {
        _contentlabel = [UILabel new];
        _contentlabel.font = TWJFont(15);
        _contentlabel.textColor = APP_HEXCOLOR(@"#333333");
    }
    return _contentlabel;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    [self addSubview:self.titlelabel];
    [self addSubview:self.contentlabel];
    self.lineView.hidden = NO;
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
