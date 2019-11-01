//
//  TWJHomeBrokenTableViewCell.m
//  TWJ
//
//  Created by ydd on 2019/7/22.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHomeBrokenTableViewCell.h"

@implementation TWJHomeBrokenTableViewCell

- (UILabel *)selecTimeLabel {
    if (!_selecTimeLabel) {
        _selecTimeLabel = [UILabel new];
        _selecTimeLabel.font = TWJFont(13);
        _selecTimeLabel.textAlignment = NSTextAlignmentCenter;
        _selecTimeLabel.userInteractionEnabled = NO;
    }
    return _selecTimeLabel;
}

- (void)commonInit {
    [super commonInit];
    
    [self addSubview:self.selecTimeLabel];
    
    [self.selecTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
