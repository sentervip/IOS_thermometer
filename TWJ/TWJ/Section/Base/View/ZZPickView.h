//
//  ZZPickView.h
//  SevenRainbow
//
//  Created by 占永辉 on 15/12/2.
//  Copyright © 2015年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MBProgressHUD+Add.h"
typedef void(^pickAciotn)(NSString *);;

@interface ZZPickView : UIView

//数据源 ---
@property(nonatomic,strong) NSArray *dataSource;
@property(nonatomic,strong) UIColor *barColor;
@property(nonatomic,strong) NSString *dateString;
@property(nonatomic,copy)pickAciotn action;
@property(nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSMutableArray *seleIndex;
//@property(nonatomic,copy)  timeBlock result;

-(void)showWithTarget:(id)target;
-(void)show;
-(void)dissmiss;
-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component;
-(void)reloadPickView;

@end
