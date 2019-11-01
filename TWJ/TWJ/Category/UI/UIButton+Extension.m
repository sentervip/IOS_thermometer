
#import "UIButton+Extension.h"
#import <objc/runtime.h>

@implementation UIButton (Extension)

@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"KEY_HIT_TEST_EDGE_INSET";

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

-(UIButton *)initNavigationButton:(UIImage *)image{
    CGRect buttonFrame = CGRectZero;
    buttonFrame = CGRectMake(0, 0, image.size.width, NAV_BAR_HEIGHT);
 
    if ( buttonFrame.size.width < NAV_BUTTON_MIN_WIDTH ) {
        buttonFrame.size.width = NAV_BUTTON_MIN_WIDTH;
    }
    
    if ( buttonFrame.size.height < NAV_BUTTON_MIN_HEIGHT ) {
        buttonFrame.size.height = NAV_BUTTON_MIN_HEIGHT;
    }
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    [self setImage:image forState:UIControlStateNormal];
    return self;
}
-(UIButton *)initNavigationButtonWithTitle:(NSString *)str color:(UIColor *)color{
    CGRect buttonFrame = CGRectZero;
    
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(999999.0f, NAV_BAR_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
    
    buttonFrame = CGRectMake(0, 0, titleSize.width, NAV_BAR_HEIGHT);
    
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitle:str forState:UIControlStateNormal];
    return self;
}

- (void)ydy_loadBottonBackgroudImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeImageName radius:(CGFloat)radius state:(UIControlState)state isBackgroud:(BOOL )isBG{
    
    if (placeImageName == nil) {
        placeImageName = @"pho-user";//通用站位图
    }
    UIImage * placeImage = [UIImage imageNamed:placeImageName];
    [self ydy_loadBottonBackgroudImageUrlStr:urlStr placeHolderImage:placeImage radius:radius state:state isBackgroud:isBG];
}

- (void)ydy_loadBottonBackgroudImageUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)placeImage radius:(CGFloat)radius state:(UIControlState)state isBackgroud:(BOOL )isBG{
    //something
    //这里有针对不同需求的处理，我就没贴出来了
    //...
    
    NSURL *url;
    
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    
    url = [NSURL URLWithString:urlStr];

//    if (radius != 0.0) {
//        //头像需要手动缓存处理成圆角的图片
//        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
//        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
//        if (cacheImage) {
//            [self setImageWithIsBackgroud:isBG andImage:cacheImage state:state];
//        }
//        else {
//            if (isBG) {
//                [self sd_setBackgroundImageWithURL:url forState:state placeholderImage:placeImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    if (!error) {
//                        [self radiusImageWith:image andRadius:radius urlStr:urlStr cacheurlStr:cacheurlStr isBackgroud:isBG state:state];
//                    }
//                }];
//            }else{
//                [self sd_setImageWithURL:url forState:state placeholderImage:placeImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    if (!error) {
//                        [self radiusImageWith:image andRadius:radius urlStr:urlStr cacheurlStr:cacheurlStr isBackgroud:isBG state:state];
//                    }
//                }];
//            }
//        }
//    }
//    else {
//        if (isBG) {
//           [self sd_setBackgroundImageWithURL:url forState:state placeholderImage:placeImage];
//        }else{
//           [self sd_setImageWithURL:url forState:state placeholderImage:placeImage];
//        }
//    }
}

- (void)setImageWithIsBackgroud:(BOOL )isBG andImage:(UIImage *)image state:(UIControlState )state{
    if (isBG) {
        [self setBackgroundImage:image forState:state];
    }else{
        [self setImage:image forState:state];
    }
}


- (void)radiusImageWith:(UIImage *)image andRadius:(CGFloat )radius urlStr:(NSString *)urlStr cacheurlStr:(NSString *)cacheurlStr isBackgroud:(BOOL )isBG state:(UIControlState )state{
//    UIImage *radiusImage = [image ydy_imageWithRoundedCornersAndSize:self.frame.size andCornerRadius:radius];
//    [self setImageWithIsBackgroud:isBG andImage:radiusImage state:state];
//    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr];
//    //清除原有非圆角图片缓存
//    [[SDImageCache sharedImageCache] removeImageForKey:urlStr];
}

- (UIButton *)ydy_initBackBtnWithTarget:(id)target action:(SEL)action{
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame: CGRectMake(0, 0, 50, 32)];
    [backBtn setImage:[UIImage imageNamed:@"icon-arrow"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icon-arrow"] forState:UIControlStateHighlighted];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return backBtn;
}

- (UIButton *)ydy_initLoginBackBtnWithTarget:(id)target action:(SEL)action{
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame: CGRectMake(0, 0, 50, 32)];
    [backBtn setImage:[UIImage imageNamed:@"icon-arrow"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icon-arrow"] forState:UIControlStateHighlighted];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return backBtn;
}


@end
