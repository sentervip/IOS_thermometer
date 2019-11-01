
#import "TWJTimePickerView.h"

@interface TWJTimePickerView()
@property (nonatomic, strong) UIWindow  * actionWindow;
@property (nonatomic, strong) UIView    * bgView;
@property (nonatomic, strong) UIButton  * cancelBtn;
@property (nonatomic, strong) UIButton  * okBtn;
@property (nonatomic, strong) UILabel   * titleLabel;

@end

@implementation TWJTimePickerView

- (void)didButtonClick:(UIButton *)sender{
    [self dismissWithAnimation:YES];
    NSInteger index = sender.tag;
    if ((index-10)&&[self.delegate respondsToSelector:@selector(XKTimePickerView:clickBtnAtIndex:timeData:)]) {
        NSDate *timeDate = self.datePicker.date;
        [self.delegate XKTimePickerView:self clickBtnAtIndex:index-10 timeData:timeDate];
    }
}

#pragma mark - pricate methods

- (void)commonInit{
    self.backgroundColor = [UIColor clearColor];
}

- (instancetype)initWithOkBtnTitle:(NSString *)okBtnTitle
                    cancleBtnTitle:(NSString *)cancleTitle
                          delegate:(id <TWJTimePickerViewDelegate>)delegate{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        [self commonInit];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.datePicker];
        [self.bgView addSubview:self.cancelBtn];
        [self.bgView addSubview:self.okBtn];
        [self.bgView addSubview:self.titleLabel];
        
        [self.okBtn setTitle:okBtnTitle forState:UIControlStateNormal];
        [self.cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
        
        self.delegate = delegate;
        [self addAutoLayout];
    }
    return self;
}

- (void)showInView:(UIView *)view{
    CGRect viewBounds = view.frame;
    self.actionWindow = [[UIWindow alloc] initWithFrame:viewBounds];
    self.actionWindow.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    self.actionWindow.windowLevel = UIWindowLevelAlert;
    self.actionWindow.hidden = NO;
   
    [self.actionWindow addGestureRecognizer:({
        UITapGestureRecognizer *gesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(dismiss)];
        gesture.numberOfTapsRequired = 1;
        gesture;
    })];
  
    [self.actionWindow addSubview:self];
}

- (void)dismiss{
    [self dismissWithAnimation:YES];
}

- (void)dismissWithAnimation:(BOOL)animation{
    if (animation) {
        [self removeFromSuperview];
        self.actionWindow.hidden = YES;
        self.actionWindow = nil;
        return;
    }
}

- (void)addAutoLayout{
  
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).with.offset(KSCREEN_HEIGHT - (KSCREEN_HEIGHT/3+44));
        make.height.equalTo(@(KSCREEN_HEIGHT/3+44));
    }];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.mas_bottom);
        make.left.equalTo(self.bgView.mas_left);
        make.right.equalTo(self.bgView.mas_right);
        make.height.equalTo(@(KSCREEN_HEIGHT/3));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top);
        make.left.equalTo(self.bgView.mas_left);
        make.width.equalTo(@(80));
        make.height.equalTo(@(44));
    }];
    
//    float width = [LanStr(@"save") getWidthWithFont:15 height:100];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top);
        make.width.equalTo(@(80));
        make.right.equalTo(self.bgView.mas_right);
        make.height.equalTo(@(44));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top);
//        make.width.equalTo(@(80));
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.height.equalTo(@(44));
    }];
}

#pragma mark - getter or setter

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
//        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor=[UIColor whiteColor];
    }
    return _datePicker;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        _cancelBtn.layer.borderWidth = 0.5f;
//        _cancelBtn.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0f].CGColor;
        _cancelBtn.tag = 10;
        [_cancelBtn addTarget:self action:@selector(didButtonClick:) forControlEvents:UIControlEventTouchDown];
        _cancelBtn.titleLabel.font = TWJFont(16);
    }
    return _cancelBtn;
}

-(UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc]init];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:APP_HEXCOLOR(@"#00c9af") forState:UIControlStateNormal];
//        _okBtn.layer.borderWidth = 0.5f;
//        _okBtn.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0f].CGColor;
        _okBtn.tag = 11;
        [_okBtn addTarget:self action:@selector(didButtonClick:) forControlEvents:UIControlEventTouchDown];
        _okBtn.titleLabel.font = TWJFont(16);
    }
    return _okBtn;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"";
        _titleLabel.font = TWJFont(17);
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

@end
