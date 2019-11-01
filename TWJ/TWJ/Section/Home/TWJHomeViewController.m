//
//  TWJHomeViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/8.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJHomeViewController.h"
#import "TWJHomeBrokenLineView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface TWJHomeViewController ()<TWJHomeBrokenLineViewDelegate>
{
    CGPoint beginPoint;
}
@property (nonatomic, strong) AVAudioPlayer              *player;

@property (nonatomic,strong)UIView *topBackView;
@property (nonatomic,strong)UIImageView *topBackImageView;

@property (nonatomic,strong)UILabel *temperatureLabel;
@property (nonatomic,strong)UILabel *temCharectLabel;
@property (nonatomic,strong)UILabel *highTemTiplabel;
@property (nonatomic,strong)TWJHomeBrokenLineView *homeBrokenLineView;

@property (nonatomic,assign)NSInteger timeInset;
@property (nonatomic,strong)NSTimer *refreshTimer;

@property (nonatomic,strong)NSString *highWaring;
@property (nonatomic,strong)NSString *lowWaring;

@property (nonatomic,assign)int temType;

@property (nonatomic,strong)NSString* lastTemretrue;

@property (nonatomic,strong)NSMutableArray* temArray;

@end

@implementation TWJHomeViewController
#pragma mark get
- (UIImageView *)topBackImageView {
    if (!_topBackImageView) {
        _topBackImageView = [UIImageView new];
        _topBackImageView.image = [UIImage imageNamed:@"home_circle"];
    }
    return _topBackImageView;
}

- (UIView *)topBackView {
    if (!_topBackView) {
        _topBackView = [UIView new];
        _topBackView.backgroundColor = APP_HEXCOLOR(@"#00c9af");
    }
    return _topBackView;
}

- (UILabel *)temperatureLabel {
    if (!_temperatureLabel) {
        _temperatureLabel = [UILabel new];
        _temperatureLabel.textColor = [UIColor whiteColor];
        _temperatureLabel.text = @"37.5";
        _temperatureLabel.font = TWJFont(60);
    }
    return _temperatureLabel;
}

- (UILabel *)temCharectLabel {
    if (!_temCharectLabel) {
        _temCharectLabel = [UILabel new];
        _temCharectLabel.textColor = [UIColor whiteColor];
        _temCharectLabel.text = TWJSheShiDuSymbol;
        _temCharectLabel.font = TWJFont(20);
    }
    return _temCharectLabel;
}

- (UILabel *)highTemTiplabel {
    if (!_highTemTiplabel) {
        _highTemTiplabel = [UILabel new];
        _highTemTiplabel.textColor = [UIColor whiteColor];
        _highTemTiplabel.text = @"温度过高，建议立即就医或服药";
        _highTemTiplabel.font = TWJFont(15);
        _highTemTiplabel.hidden = YES;
    }
    return _highTemTiplabel;
}

- (TWJHomeBrokenLineView *)homeBrokenLineView {
    if (!_homeBrokenLineView) {
        _homeBrokenLineView = [TWJHomeBrokenLineView new];
        _homeBrokenLineView.delegate = self;
    }
    return _homeBrokenLineView;
}

- (AVAudioPlayer *)player {
    if (!_player) {
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"temWaringVoice.mp3"  withExtension:nil] error:nil ];
//        _player.volume = 0.5;
        _player.numberOfLoops = 1;
        [_player prepareToPlay];
    }
    return _player;
}

- (NSMutableArray *)temArray {
    if (!_temArray) {
        _temArray = [[NSMutableArray alloc] initWithObjects:@"35.1",@"35.1",@"35.1",@"35.1",@"35.1",@"35.1",@"35.1", nil];
    }
    return _temArray;
}

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self selectBaby];
   
    [self configSubviews];
    
    self.topBackView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.topBackView addGestureRecognizer:recognizer];
    
    self.timeInset = 5;
    [self creatTimer:5];
    
    NSString *hight = [[NSUserDefaults standardUserDefaults] objectForKey:TWJHightTempretrueKey];
    if (hight) {
        self.highWaring = hight;
    }else {
        self.highWaring = @"";
    }
    
    NSString *low = [[NSUserDefaults standardUserDefaults] objectForKey:TWJLowTempretrueKey];
    if (low) {
        self.lowWaring = low;
    }else {
        self.lowWaring = @"";
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveTemptureValue:) name:TWJReciveTempetureValueNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tempetureSetting:) name:TWJTempetureSettingValueNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDisConect:) name:TWJDeviceDisContectValueNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if (self.temType == 2) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:APP_HEXCOLOR(@"#ff8955")] forBarMetrics:UIBarMetricsDefault];
    }else if (self.temType == 3) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:APP_HEXCOLOR(@"#629afe")] forBarMetrics:UIBarMetricsDefault];
    }else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:APP_HEXCOLOR(@"#00c9af")] forBarMetrics:UIBarMetricsDefault];
    }
    

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

}

- (void)dealloc {
    
}

#pragma mark UI
- (void)configSubviews {
    [super configSubviews];
    
    [self.view addSubview:self.topBackView];
    [self.topBackView addSubview:self.topBackImageView];
    [self.topBackView addSubview:self.temperatureLabel];
    [self.topBackView addSubview:self.temCharectLabel];
    [self.topBackView addSubview:self.highTemTiplabel];
    [self.view addSubview:self.homeBrokenLineView];
    
    [self addAutoLayout];
}

- (void)addAutoLayout {
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.height.equalTo(@(512*KSCREEN_WIDTH/750 + 10));
    }];
    
    [self.topBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBackView.mas_top);
        make.centerX.equalTo(self.topBackView.mas_centerX);
        make.width.equalTo(@(244*KSCREEN_WIDTH/375));
        make.height.equalTo(@(234*KSCREEN_WIDTH/375));
    }];
    
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topBackImageView.mas_centerX);
        make.centerY.equalTo(self.topBackImageView.mas_centerY);
//        make.top.equalTo(self.topBackView.mas_top).offset(80);
    }];
    
    [self.temCharectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.temperatureLabel.mas_right);
        make.bottom.equalTo(self.temperatureLabel.mas_bottom).offset(-8);
    }];
    
    [self.highTemTiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topBackView.mas_bottom).offset(-10);
        make.centerX.equalTo(self.topBackView.mas_centerX);
    }];
    
    [self.homeBrokenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topBackView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)selectBaby {
    NSArray *array = [[TWJDataBaseManager sharedInstance] getAllBabyinfo];
    if (array.count == 0) {
        TWJBabyInfoModel *model = array[0];
        self.navigationItem.title = model.name;
    }else if (array.count > 1) {
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"选择宝贝" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (int i = 0; i < array.count; i++) {
            TWJBabyInfoModel *model = array[i];
            UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ | %@岁",model.name,model.age] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.navigationItem.title = model.name;
            }];
            [alertControl addAction:alertAction1];
        }
        
        [self presentViewController:alertControl animated:YES completion:^{  }];
        
    }else {
        self.navigationItem.title = @"体温计";
    }
}

#pragma mark 手势，点击
- (void)panGesture:(UIPanGestureRecognizer *)swipe {
    if(swipe.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [swipe locationInView:self.topBackView];
        beginPoint = point;
    }else if(swipe.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [swipe locationInView:self.topBackView];
        [self comparePoint:point];
    }
}

- (void)comparePoint:(CGPoint)point {
    if (point.y > beginPoint.y) {
        [self.topBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        [self.topBackImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topBackView.mas_centerX);
            make.centerY.equalTo(self.topBackView.mas_centerY).offset(-48);
            make.width.equalTo(@(244));
            make.height.equalTo(@(234));
        }];
    }else {
        [self.topBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(0);
            make.height.equalTo(@(512*KSCREEN_WIDTH/750 + 10));
        }];
        
        [self.topBackImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topBackView.mas_top);
            make.centerX.equalTo(self.topBackView.mas_centerX);
            make.width.equalTo(@(244));
            make.height.equalTo(@(234));
        }];
    }
}

#pragma mark qita

- (void)creatTimer:(NSInteger)sec {
    if (self.refreshTimer) {
        [self.refreshTimer invalidate];
        self.refreshTimer = nil;
    }
    NSTimeInterval timinter = 2;
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:timinter target:self selector:@selector(refreshui:) userInfo:nil repeats:YES];
    [self.refreshTimer fire];
}

- (void)refreshui:(id)sender {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getTimeTemperatureArray:self.timeInset];
//    });
}

/**
 根据高低温度改变颜色，响铃

 @param type 1-正常 、2-高温、3-低温
 */
- (void)changeTopbackColorWithType:(int)type {
    if (type == 1) {
        self.topBackView.backgroundColor = APP_HEXCOLOR(@"#00c9af");
        self.highTemTiplabel.hidden = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:APP_HEXCOLOR(@"#00c9af")] forBarMetrics:UIBarMetricsDefault];
    }else if (type == 2) {
        self.topBackView.backgroundColor = APP_HEXCOLOR(@"#ff8955");
        self.highTemTiplabel.hidden = NO;
        
        [self.player play];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:APP_HEXCOLOR(@"#ff8955")] forBarMetrics:UIBarMetricsDefault];
    }else {
        self.topBackView.backgroundColor = APP_HEXCOLOR(@"#629afe");
        self.highTemTiplabel.hidden = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:APP_HEXCOLOR(@"#629afe")] forBarMetrics:UIBarMetricsDefault];
        
        [self.player play];
    }
}



- (void)getTimeTemperatureArray:(NSInteger)timeInter {
    NSDate *nowdate = [NSDate date];
    
//    NSMutableArray *temArray = [[NSMutableArray alloc] init];
//
//    long k = timeInter * 7 ;
//    float high = 0;
//    for (int i = 0; i<7; i++) {
//        k -= timeInter ;
////        NSLog(@"kkkk:%ld",k);
//        NSTimeInterval time = k * 60;
//        NSDate *lastDate = [nowdate dateByAddingTimeInterval:-time];
////        NSLog(@"time:%f",time);
////        NSLog(@"lastDate:%@",lastDate);
//        NSString *timestring = [NSString getDateStringWithDate:lastDate formate:@"yyyy年MM月dd日 HH时mm分"];
//        NSArray *array = [[TWJDataBaseManager sharedInstance] getTemperatureWithTime:timestring];
//
//        float total = 0;
//        float value = 35.1;
//        if (array.count != 0) {
//            for (int j = 0; j < array.count; j ++) {
//                TWJTemperatureModel *model = [array objectAtIndex:j];
//                total += [model.temperature floatValue];
////                NSLog(@"time:%@",model.timeString);
//            }
//            value = total/array.count;
//            if (value > high) {
//                high = value;
//            }
//        }
////        NSLog(@"value:%f",value);
//        [temArray addObject:[NSString stringWithFormat:@"%.2f",value]];
//    }
    
    long h =  2 * 4;
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.temArray.count; i+=2) {
        h -= 2 ;
        NSTimeInterval time = h ;
        NSDate *lastDate = [nowdate dateByAddingTimeInterval:-time];
        NSString *timestring = [NSString getDateStringWithDate:lastDate formate:@"HH:mm:ss"];
        [timeArray addObject:timestring];
    }
    
//    [self.homeBrokenLineView.drawChartView drawZheXianTu:timeArray and:temArray];
    [self.homeBrokenLineView updateLine:timeArray yArray:self.temArray];
    
}

#pragma mark TWJHomeBrokenLineViewDelegate
- (void)selectTimeInterval:(NSString *)instervalString {
    if ([instervalString isEqualToString:TWJTimeInterval5min]) {
//        NSTimeInterval time = 5 * 60;
        self.timeInset = 5;
        
    }else if ([instervalString isEqualToString:TWJTimeInterval15min]) {
        self.timeInset = 15;
    }else if ([instervalString isEqualToString:TWJTimeInterval30min]) {
        self.timeInset = 30;
    }else if ([instervalString isEqualToString:TWJTimeInterval1h]) {
        
        
    }else if ([instervalString isEqualToString:TWJTimeInterval12h]) {
        
        
    }
    
//    [self creatTimer:self.timeInset];

}

#pragma mark 通知
- (void)reciveTemptureValue:(NSNotification *)notication {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *s = notication.object;
        [self.temArray removeObjectAtIndex:0];
        [self.temArray addObject:s];
        
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f",[s floatValue]];
        
        if ([self.lastTemretrue floatValue] < [s floatValue]) {
            self.homeBrokenLineView.highestTemLabel.text = [NSString stringWithFormat:@"最高温度：%.1f%@",[s floatValue],TWJSheShiDuSymbol];
            self.lastTemretrue = s;
        }else {
            
        }
        
        int type = 1;
        if ([self.highWaring floatValue] < [s floatValue] && self.highWaring.length > 0) {
            //高温报警
            type = 2;
            
        }else if ([self.lowWaring floatValue] > [s floatValue] && self.lowWaring.length > 0) {
            //低温报警
            
            type = 3;
        }else {
            //正常
            type = 1;
        }
        
        if (type == self.temType) {
            
        }else {
            self.temType = type;
            [self changeTopbackColorWithType:type];
        }
    });
}

- (void)tempetureSetting:(NSNotification *)notication {
    NSString *s = notication.object;
    NSString *value ;
    if ([s integerValue] == 0) {
        value = [[NSUserDefaults standardUserDefaults] objectForKey:TWJHightTempretrueKey];
        self.highWaring = value;
    }else {
        value = [[NSUserDefaults standardUserDefaults] objectForKey:TWJLowTempretrueKey];
        self.lowWaring = value;
    }
}

- (void)deviceDisConect:(NSNotification *)notice {
    [self.player play];
    
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.player pause];
    }];

                
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备连接已断开" preferredStyle:UIAlertControllerStyleAlert];
    [alertControl addAction:alertAction1];
    [self presentViewController:alertControl animated:YES completion:^{  }];
}

@end
