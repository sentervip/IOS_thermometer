//
//  TWJTemperatureRecordTableViewCell.h
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWJTemperatureRecordTableViewCell : TWJTableViewCell
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *recordLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@end

NS_ASSUME_NONNULL_END
