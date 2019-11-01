

#import "UINavigationBar+Extension.h"
#import <objc/runtime.h>

static const char YDYOverlay;
static const char YDYOverlayLine;

@interface UINavigationBar ()

@property (strong, nonatomic) CALayer *ydyOverlay;
@property (strong, nonatomic) CALayer *ydyOverlayLine;

@end

@implementation UINavigationBar (Extension)

- (CALayer *)ydyOverlay {
    if (!objc_getAssociatedObject(self, &YDYOverlay)) {
        CALayer *layer = [CALayer new];
        layer.frame = CGRectMake(0, /*-20*/0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds)+20);
        objc_setAssociatedObject(self, &YDYOverlay, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, &YDYOverlay);
}

- (CALayer *)ydyOverlayLine {
    if (!objc_getAssociatedObject(self, &YDYOverlayLine)) {
        CALayer *layer = [CALayer new];
        layer.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
        objc_setAssociatedObject(self, &YDYOverlayLine, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, &YDYOverlayLine);
}

- (void)ydy_setBackgroundColor:(UIColor *)color {
    self.barStyle = UIBarStyleDefault;
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
    [self.ydyOverlay removeFromSuperlayer];
    self.ydyOverlay.backgroundColor = color.CGColor;
    [[self.layer.sublayers firstObject] insertSublayer:self.ydyOverlay atIndex:0];
}

- (void)ydy_setLineBarColorInLogin:(UIColor *)color{
    
    self.barStyle = UIBarStyleDefault;
    [self.ydyOverlay removeFromSuperlayer];
    self.ydyOverlayLine.backgroundColor = color.CGColor;
    [self.layer  insertSublayer:self.ydyOverlayLine atIndex:0];
}

//- (void)ydy_setBackgroundColor:(UIColor *)barTintColor {
//    self.barTintColor = barTintColor;
//    [self setSubviewBgColor:barTintColor inView:self];
//}

- (void)setSubviewBgColor:(UIColor *)color inView:(UIView *)view {
    Class UINavigationBarBackgroundClass = NSClassFromString(@"_UINavigationBarBackground");
    if ([view isKindOfClass:[UINavigationBarBackgroundClass class]]) {
        [view setBackgroundColor:color];
    }
    for (UIView *sub in view.subviews) {
        Class UIBackdropViewClass = NSClassFromString(@"_UIBackdropView");
        if ([sub isKindOfClass:[UIBackdropViewClass class]]) {
            [sub setAlpha:0];
        } else {
            [self setSubviewBgColor:color inView:sub];
            
        }
    }
}



- (void)ydy_hiddenNavigationBarBottomLine {
    [self findNavigationBarBottomLine:self];
}

- (void)findNavigationBarBottomLine:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        [view removeFromSuperview];
    } else {
        for (UIView *subview in view.subviews) {
            [self findNavigationBarBottomLine:subview];
        }
    }
}

- (void)ydy_setBackgroundColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize{

    [self ydy_setBackgroundColor:bgColor];
    [self setTitleTextAttributes: @{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleSize}];
}


//STCreate 新增优化方法，后期可添加到viewWillDisappear中
- (void)ydy_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.ydyOverlay removeFromSuperlayer];
    self.ydyOverlay = nil;
    [self.ydyOverlayLine removeFromSuperlayer];
    self.ydyOverlayLine = nil;
}

@end
