//
//  TWJHomeBrokenLineView.h
//  TWJ
//
//  Created by ydd on 2019/7/15.
//  Copyright © 2019 zlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWJView.h"
#import "TWJDrawChartView.h"

#define TWJTimeInterval5min     @"5m"
#define TWJTimeInterval15min    @"15m"
#define TWJTimeInterval30min    @"30m"
#define TWJTimeInterval1h       @"1h"
#define TWJTimeInterval12h      @"12h"

NS_ASSUME_NONNULL_BEGIN
@protocol TWJHomeBrokenLineViewDelegate <NSObject>

- (void)selectTimeInterval:(NSString *)instervalString;

@end

@interface TWJHomeBrokenLineView : TWJView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)id<TWJHomeBrokenLineViewDelegate> delegate;

@property (nonatomic,strong)UILabel *highestTemLabel;
@property (nonatomic,strong)UIButton *selectTimeButton;
@property (nonatomic,strong)UITableView *selectTableView;

@property (nonatomic,strong)TWJDrawChartView *drawChartView;

- (void)updateLine:(NSArray *)xarray yArray:(NSArray *)yArray;


@end

NS_ASSUME_NONNULL_END
