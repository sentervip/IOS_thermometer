//
//  DrawChart.m
//  DrawPicture
//
//  Created by admin on 16/11/25.
//  Copyright © 2016年 voquan. All rights reserved.
//

#import "TWJDrawChartView.h"


#define margin      (self.bounds.size.height/10.5)
#define zzWidth     self.bounds.size.width
#define zzHeight    self.bounds.size.height

// 颜色RGB
#define zzColor(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define zzColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 随机色
#define zzRandomColor  zzColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface TWJDrawChartView ()
{
    
}
@property (nonatomic,strong)NSMutableArray *xlabelArray;
@property (nonatomic,strong)UILabel *currentLabel;
@property (nonatomic,strong)CAShapeLayer*  zhexianlayer;

@end

@implementation TWJDrawChartView

//- (NSArray *)yArray {
//    if (!_yArray) {
//        _yArray = @[@"",@"35.5",@"36.0",@"36.5",@"37.0",@"37.5",@"38.0",@"38.5"];
//    }
//    return _yArray;
//}

- (UILabel *)currentLabel {
    if (!_currentLabel) {
        _currentLabel = [UILabel new];
        _currentLabel.textColor = [UIColor blackColor];
        _currentLabel.font = [UIFont systemFontOfSize:10];
        _currentLabel.textAlignment = NSTextAlignmentCenter;
        _currentLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _currentLabel;
}

- (NSMutableArray *)xlabelArray {
    if (!_xlabelArray) {
        _xlabelArray = [[NSMutableArray alloc] init];
        
    }
    return _xlabelArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
    
        
    }
    
    return self;
}

//画坐标轴
- (void)drawZuoBiaoXi:(NSArray *)x_itemArr{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //坐标轴原点
    CGPoint rPoint = CGPointMake(margin, zzHeight-margin);
    
//    //画y轴
//    [path moveToPoint:rPoint];
//    [path addLineToPoint:CGPointMake(margin, margin)];
//
//    //画y轴的箭头
//    [path moveToPoint:CGPointMake(margin, margin)];
//    [path addLineToPoint:CGPointMake(margin-5, margin+5)];
//    [path moveToPoint:CGPointMake(margin, margin)];
//    [path addLineToPoint:CGPointMake(margin+5, margin+5)];

    //画x轴
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(zzWidth-margin, zzHeight-margin)];
    
//    //画x轴的箭头
//    [path moveToPoint:CGPointMake(zzWidth-margin, zzHeight-margin)];
//    [path addLineToPoint:CGPointMake(zzWidth-margin-5, zzHeight-margin-5)];
//    [path moveToPoint:CGPointMake(zzWidth-margin, zzHeight-margin)];
//    [path addLineToPoint:CGPointMake(zzWidth-margin-5, zzHeight-margin+5)];
    
    
    //画x轴上的标度
    for (int i=0; i<7; i++) {
        
        [path moveToPoint:CGPointMake(2*margin+1.5*margin*i, zzHeight-margin)];
        [path addLineToPoint:CGPointMake(2*margin+1.5*margin*i, zzHeight-margin-3)];
  
    }
    
    //画y轴上的标度
    for (int i=0; i<7; i++) {

        [path moveToPoint:CGPointMake(margin, zzHeight-2*margin-margin*i)];
        [path addLineToPoint:CGPointMake(margin+3, zzHeight-2*margin-margin*i)];
    }
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 2.0;
    [self.layer addSublayer:layer];
    
    //给y轴加标注
    NSArray* arr = @[@"",@"35.5",@"36.0",@"36.5",@"37.0",@"37.5",@"38.0",@"38.5"];
    for (int i=0; i<arr.count; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(margin-25, zzHeight-margin-margin*i-10, 25, 20)];
        lab.text = [NSString stringWithFormat:@"%@", arr[i]];
        lab.textColor = APP_HEXCOLOR(@"#666666");
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}

//画柱状图
- (void)drawZhuZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr{
    
    
    [self initDrawView];
    
    //建立坐标轴
    [self drawZuoBiaoXi:x_itemArr];
    
    //画柱状图
    for (int i=0; i<x_itemArr.count; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(2*margin+1.5*margin*i, zzHeight-margin-3*[y_itemArr[i] floatValue], 0.8*margin, 3*[y_itemArr[i] floatValue])];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = zzRandomColor.CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
    }

    //给x轴加标注
    for (int i=0; i<x_itemArr.count; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(2*margin+1.5*margin*i, zzHeight-margin, 0.8*margin, 20)];
        lab.text = x_itemArr[i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}


//画饼形图
- (void)drawBingZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr{
    
    
    [self initDrawView];
    
    CGPoint yPoint = CGPointMake(zzWidth/2, zzHeight/2);
    CGFloat startAngle = 0;
    CGFloat endAngle;
    float r = 100.0;
    
    //求和
    float sum=0;
    for (NSString *str in y_itemArr) {
        
        sum += [str floatValue];
    }
    
    for (int i=0; i<x_itemArr.count; i++) {
        
        //求每一个的占比
        float zhanbi = [y_itemArr[i] floatValue]/sum;
        
        endAngle = startAngle + zhanbi*2*M_PI;
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:yPoint radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path addLineToPoint:yPoint];
        [path closePath];
        
        
        CGFloat lab_x = yPoint.x + (r + 30/2) * cos((startAngle + (endAngle - startAngle)/2)) - 30/2;
        CGFloat lab_y = yPoint.y + (r + 20/2) * sin((startAngle + (endAngle - startAngle)/2)) - 20/2;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(lab_x, lab_y, 30, 20)];
        lab.text = x_itemArr[i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        
        
        layer.path = path.CGPath;
        layer.fillColor = zzRandomColor.CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];

        startAngle = endAngle;
    }
}

//画折线图
- (void)drawZheXianTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr{
    
    [self initDrawView];
    
    [self drawZuoBiaoXi:x_itemArr];
    
    CGPoint startPoint = CGPointMake(2*margin, zzHeight-margin-(([y_itemArr[0] floatValue]-35.0)/0.5)*margin);//xx*[y_itemArr[0] floatValue])
    CGPoint endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i=0; i<7; i++) {
    
        endPoint = CGPointMake(2*margin+1.5*margin*i, zzHeight-margin-(([y_itemArr[i] floatValue]-35.0)/0.5)*margin);
        
        [path moveToPoint:startPoint];
        [path addArcWithCenter:endPoint radius:1.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
        [path addLineToPoint:endPoint];
        
        
//        CAShapeLayer *layer1 = [CAShapeLayer layer];
//        layer1.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
//        layer1.backgroundColor = [UIColor blackColor].CGColor;
//        [self.layer addSublayer:layer1];
        
        //绘制虚线
//        [self drawXuxian:endPoint];
        
        
        startPoint = endPoint;
        
    }
    CAShapeLayer* zhexianlayer = [CAShapeLayer layer];
    zhexianlayer.path = path.CGPath;
    zhexianlayer.strokeColor = [UIColor blackColor].CGColor;
    zhexianlayer.lineWidth = 1.0;
    [self.layer addSublayer:zhexianlayer];
    self.zhexianlayer = zhexianlayer;
    
    [self addSubview:self.currentLabel];
    self.currentLabel.frame = CGRectMake(endPoint.x - margin, endPoint.y - 25, 2*margin, 20);
    
    //给x轴加标注
//    if (self.xlabelArray.count == 0) {
        for (int i=0; i<x_itemArr.count; i++) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(margin+2*1.5*margin*i, zzHeight-margin, 2*margin, 20)];
            lab.text = x_itemArr[i];
            lab.textColor = [UIColor blackColor];
            lab.font = [UIFont systemFontOfSize:10];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.adjustsFontSizeToFitWidth = YES;
            lab.tag = 100+i;
            [self addSubview:lab];
            
            [self.xlabelArray addObject:lab];
        }
//    }else {
//        [self updatezhexianX:x_itemArr];
//    }
}

- (void)updatezhexianX:(NSArray *)xTextArray {
    if (xTextArray.count == self.xlabelArray.count) {
        for (int i = 0; i < self.xlabelArray.count; i++) {
            UILabel *laebl = [self.xlabelArray objectAtIndex:i];
            NSString *text = [xTextArray objectAtIndex:i];
            
            laebl.text = text;
        }
        
    }
}

- (void)updatezhexianY:(NSArray *)y_itemArr {
    if (self.zhexianlayer) {
        [self.zhexianlayer removeFromSuperlayer];
    }
    
    CGPoint startPoint = CGPointMake(2*margin, zzHeight-margin-(([y_itemArr[0] floatValue]-35.0)/0.5)*margin);
    CGPoint endPoint;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i=0; i<7; i++) {
    
        endPoint = CGPointMake(2*margin+1.5*margin*i, zzHeight-margin-(([y_itemArr[i] floatValue]-35.0)/0.5)*margin);
        
        [path moveToPoint:startPoint];
        [path addArcWithCenter:endPoint radius:1.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
        [path addLineToPoint:endPoint];
        
        startPoint = endPoint;
        
    }
    
    self.currentLabel.frame = CGRectMake(endPoint.x - margin, endPoint.y - 25, 2*margin, 20);
    self.currentLabel.text = [y_itemArr lastObject];
    
    CAShapeLayer *zhexianlayer = [CAShapeLayer layer];
    zhexianlayer.path = path.CGPath;
    zhexianlayer.strokeColor = [UIColor blackColor].CGColor;
    zhexianlayer.lineWidth = 1.0;
    [self.layer addSublayer:zhexianlayer];
    
    self.zhexianlayer = zhexianlayer;
    
}

//绘制虚线
- (void)drawXuxian:(CGPoint)point{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    [shapeLayer setStrokeColor:[UIColor blackColor].CGColor];

    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil]];
    
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置y轴方向的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x, zzHeight-margin);

    //设置x轴方向的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, margin, point.y);
    
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
   
    [self.layer addSublayer:shapeLayer];
}

- (void)initDrawView{
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
