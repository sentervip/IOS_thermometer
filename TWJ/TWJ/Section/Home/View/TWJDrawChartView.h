//
//  DrawChart.h
//  DrawPicture
//
//  Created by admin on 16/11/25.
//  Copyright © 2016年 voquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWJDrawChartView : UIView

@property (nonatomic,strong)NSArray *yArray;

//画柱状图
- (void)drawZhuZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr;

//画饼形图
- (void)drawBingZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr;


//画折线图
- (void)drawZheXianTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr;

- (void)updatezhexianX:(NSArray *)xTextArray;
- (void)updatezhexianY:(NSArray *)y_itemArr;

@end
