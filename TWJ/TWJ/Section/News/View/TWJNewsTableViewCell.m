//
//  TWJNewsTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJNewsTableViewCell.h"

@implementation TWJNewsTableViewCell
#pragma mark get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = TWJFont(17);
        _titleLabel.text = @"新闻标题新闻标题新闻标题新闻标题";
        _titleLabel.textColor = APP_HEXCOLOR(@"#333333");
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = TWJFont(12);
        _contentLabel.text = @"10月2号内容，10月2号内容10月2号内容10月2号内容10月2号内容。10月2号内容。";
        _contentLabel.textColor = APP_HEXCOLOR(@"#2a2a2a");
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

#pragma mark UI
- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [super addAutoLayout];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@(72));
        make.width.equalTo(@(100));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconImageView.mas_left).offset(-25);
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.mas_top).offset(11);
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconImageView.mas_left).offset(-25);
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
//        make.bottom.equalTo(self.iconImageView.mas_bottom);
    }];
}
@end
