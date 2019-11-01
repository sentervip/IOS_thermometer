//
//  ZZPickView.m
//  SevenRainbow
//
//  Created by 占永辉 on 15/12/2.
//  Copyright © 2015年 HG. All rights reserved.
//

#import "ZZPickView.h"

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface ZZPickView ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    UIView *barView;
    UIPickerView *datePicker;
    UILabel *unitLabel;
    id _target;
    UILabel *titleLabel;
    UIView *bgview;
    //NSMutableArray *dataSource;
}
@end


@implementation ZZPickView
- (NSMutableArray *)seleIndex {
    if (!_seleIndex) {
        _seleIndex = [[NSMutableArray alloc] init];
    }
    return _seleIndex;
}

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    frame.size.height = 256;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    self.frame = frame;
    if (self) {
        self.barColor = [UIColor whiteColor];//RGB(244, 244, 244);
        self.backgroundColor = RGB(255, 255, 255);
        [self configureUI];
    }
    return self;
}

-(void)configureUI{
    
    //导航图
    CGFloat barHeight = 40;
    barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, barHeight)];
    barView.backgroundColor = self.barColor;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, 0, 60, barHeight);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:APP_HEXCOLOR(@"#333333") forState:UIControlStateNormal];
    [barView addSubview:cancelButton];
    
    titleLabel=[[UILabel alloc]init];
    //label.center=barView.center;
    titleLabel.frame=CGRectMake(60, 0, KSCREEN_WIDTH-120, barHeight);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font = TWJFont(14);
    titleLabel.textColor=RGB(0, 0, 0);
    [barView addSubview:titleLabel];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    float width = [LanStr(@"save") getWidthWithFont:15 height:100];
    okButton.frame = CGRectMake(self.bounds.size.width-60, 0, 60, barHeight);
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(sureClicked:) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitleColor:APP_HEXCOLOR(@"#333333") forState:UIControlStateNormal];
    okButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    okButton.titleLabel.font = TWJFont(17);
    [barView addSubview:okButton];
    [self addSubview:barView];
    
    datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0 , barHeight, self.bounds.size.width, 216)];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    datePicker.showsSelectionIndicator = YES;
    [self addSubview:datePicker];
    
    UILabel *alabel  = [[UILabel alloc] init];
    alabel.text = @".";
    alabel.font = [UIFont boldSystemFontOfSize:25];
    alabel.textColor = APP_HEXCOLOR(@"#ff8955");
    [datePicker addSubview:alabel];
    [alabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->datePicker.mas_centerX);
        make.centerY.equalTo(self->datePicker.mas_centerY);
    }];
    
    UILabel *tlabel  = [[UILabel alloc] init];
    tlabel.text = @"℃";
    tlabel.font = [UIFont systemFontOfSize:25];
    tlabel.textColor = APP_HEXCOLOR(@"#ff8955");
    tlabel.textAlignment = NSTextAlignmentRight;
    [datePicker addSubview:tlabel];
    [tlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->datePicker.mas_centerY);
        make.right.equalTo(self->datePicker.mas_right).offset(-15);
    }];
}

-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (datePicker) {
        [datePicker selectRow:row inComponent:component animated:NO];
    }
}

-(void)reloadPickView
{
    [datePicker reloadAllComponents];
}

#pragma mark ----------- action
-(void)sureClicked:(UIButton *)sender{
    
    //数据整合
    NSInteger comment = [self numberOfComponentsInPickerView:datePicker];
    //字符串以-组合
    NSMutableString *string = [NSMutableString string];
    if (comment<3) {
    for (int i=0; i<comment;i++) {
        
        if (string.length>0) [string appendString:@""];
        NSInteger row = [datePicker selectedRowInComponent:i];
        if (comment>1) {
            [string appendString:_dataSource[i][row]];
            if (i == 0) {
                [string appendString:@"."];
            }
            
        }else if(comment == 0){
            [string appendString:_dataSource[row]];
        }else {
            [string appendString:_dataSource[row]];
        }
    }
        
        self.action(string);
        [self dissmiss];
    }
    else if (comment == 3) {
        for (int i=0; i<comment;i++) {
            
            if (string.length>0) [string appendString:@"/"];
            NSInteger row = [datePicker selectedRowInComponent:i];
            if (comment>1) {
                [string appendString:_dataSource[i][row]];
            }else{
                [string appendString:_dataSource[row]];
            }
        }
        //判断日期是否有问题
        NSArray *dateArr = [string componentsSeparatedByString:@"/"];
        
        if ([dateArr[1] integerValue] == 4 || [dateArr[1] integerValue] == 6 || [dateArr[1] integerValue] == 9 || [dateArr[1] integerValue] == 11) {
            
            if ([dateArr[2] integerValue] == 31 ) {
//               [MBProgressHUD showText:LanStr(@"The date is not correct")];
            }else{
                
                self.action(string);
                [self dissmiss];
                
            }
            
        }else if ([dateArr[1] integerValue] == 2){
            if ([dateArr[0] integerValue]%4 == 0 && [dateArr[0] integerValue]%100 == 0 && [dateArr[0] integerValue]%100 != 0) {
                
                //闰年
                if ([dateArr[2] integerValue] > 29) {
//                    [MBProgressHUD showText:LanStr(@"The date is not correct")];
                }else{
                    self.action(string);
                    [self dissmiss];
                }
                
            }else{
                //非闰年
                if ([dateArr[2] integerValue] > 28) {
//                    [MBProgressHUD showText:LanStr(@"The date is not correct")];
                }else{
                    self.action(string);
                    [self dissmiss];
                }
            }
            
        }else{
            
            self.action(string);
            [self dissmiss];  
        }

    }
}
-(void)cancelClicked:(UIButton *)sender{
    
    [self dissmiss];
    
}
-(void)showWithTarget:(id)target{

   [self animation:YES];
    _target = target;

}
-(void)show{
    
    [self animation:YES];
    bgview=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bgview.alpha=0.3;
    bgview.backgroundColor=RGB(47, 44, 43);
    [self.superview addSubview:bgview];
    [self.superview insertSubview:bgview belowSubview:self];
    titleLabel.text=self.title;
    // NSLog(@"--------%f",-CGRectGetHeight(self.bounds));
    // self.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.bounds));
    //[view addSubview:self];
    
    UITapGestureRecognizer *choosetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewTap)];
    [bgview addGestureRecognizer:choosetap];
}
-(void)bgViewTap{
    [self dissmiss];
}
-(void)dissmiss{
    if (datePicker) {
        [datePicker removeFromSuperview];
        datePicker = nil;
    }
    [self animation:NO];
    [bgview removeFromSuperview];
}
-(void)animation:(BOOL)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.transform = show ? CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.bounds)):CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)setBarColor:(UIColor *)barColor{
    _barColor = barColor;
    barView.backgroundColor = barColor;
}
-(void)setDataSource:(NSArray *)dataSource{

    if (dataSource == nil || dataSource.count <1) {
        return;
    }
    if (datePicker == nil) {
        datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0 , 40, self.bounds.size.width, 216)];
        datePicker.dataSource = self;
        datePicker.delegate = self;
        datePicker.showsSelectionIndicator = YES;
        [self addSubview:datePicker];
    }
    _dataSource = dataSource;
    [datePicker reloadAllComponents];
    if (self.seleIndex!=nil && datePicker) {
        if (self.seleIndex.count > 0) {
            [datePicker selectRow:[self.seleIndex[0] intValue] inComponent:0 animated:NO];
        }
        if (self.seleIndex.count > 1) {
            [datePicker selectRow:[self.seleIndex[1] intValue] inComponent:1 animated:NO];
        }
        if (self.seleIndex.count > 2) {
            [datePicker selectRow:[self.seleIndex[2] intValue] inComponent:2 animated:NO];
        }
    }
}
#pragma mark ------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //如果元素是数组,则有多列
    id obj = [_dataSource firstObject];
    
    if ([obj isKindOfClass:[NSArray class]]) {
        
        return _dataSource.count;
    }
    return 1;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 50;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    id obj = _dataSource[component];
    if ([obj isKindOfClass:[NSArray class]]) {
        
        return [obj count];
    }
    return _dataSource.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    id obj = _dataSource[component];
    if ([obj isKindOfClass:[NSArray class]]) {
        
        return [UIScreen mainScreen].bounds.size.width/_dataSource.count;
    }
    return 200;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    id obj = _dataSource[component]; //是一个元素
    NSString *title = nil;
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)obj;
        if (row < arr.count) {
            title = [obj[row] copy];
        }
        //return [obj count];
    }else{
        title = _dataSource[row];
    }
    if (title == nil) {
        title = @"";
    }
    NSAttributedString *attributeStr;
    if (self.seleIndex.count > 1) {
        if ([self.seleIndex[component] intValue] == row) {
            attributeStr = [[NSAttributedString alloc]initWithString:title attributes:@{NSForegroundColorAttributeName:APP_HEXCOLOR(@"#ff8955")}];
        }else {
            attributeStr = [[NSAttributedString alloc]initWithString:title attributes:@{NSForegroundColorAttributeName:RGB(0, 0, 0)}];
        }
        
    }
//    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:title attributes:@{NSForegroundColorAttributeName:RGB(0, 0, 0)}];
    return attributeStr;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"selectrow");
    if (component == 0) {
        self.seleIndex[0] = [NSString stringWithFormat:@"%ld",(long)row];
    }else if (component == 1) {
        self.seleIndex[1] = [NSString stringWithFormat:@"%ld",(long)row];
    }
    [pickerView reloadComponent:component];
}



@end
