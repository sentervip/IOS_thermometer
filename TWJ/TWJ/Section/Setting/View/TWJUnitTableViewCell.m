//
//  TWJUnitTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/24.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJUnitTableViewCell.h"

@implementation TWJUnitTableViewCell

#pragma mark get
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = TWJFont(17);
        _nameLabel.text = @"name";
        _nameLabel.textColor = APP_HEXCOLOR(@"#333333");
    }
    return _nameLabel;
}

- (UIButton *)selectbutton {
    if (!_selectbutton) {
        _selectbutton = [[UIButton alloc] init];
        _selectbutton.userInteractionEnabled = YES;
        [_selectbutton setImage:[UIImage imageNamed:@"history_normal"] forState:UIControlStateNormal];
        [_selectbutton setImage:[UIImage imageNamed:@"history_selected"] forState:UIControlStateSelected];
    }
    return _selectbutton;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.selectbutton];
    [self addSubview:self.nameLabel];
    self.lineView.hidden = NO;
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.selectbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.width.height.equalTo(@(22));
        make.centerY.equalTo(self.mas_centerY);
    }];
   
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectbutton.mas_right).offset(14);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}



@end
