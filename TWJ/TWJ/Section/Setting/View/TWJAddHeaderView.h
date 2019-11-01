//
//  TWJAddHeaderView.h
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWJAddHeaderView : TWJView
@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIView *lineview;
@property (nonatomic,strong)UIImageView *arrowImageview;

@end

@interface TWJAddFooterView : TWJView
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UISwitch *footSwitch;
@property (nonatomic,strong)UIView *lineview;
@end


NS_ASSUME_NONNULL_END
