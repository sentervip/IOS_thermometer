

#import <UIKit/UIKit.h>
#undef	NAV_BUTTON_MIN_WIDTH
#define	NAV_BUTTON_MIN_WIDTH	(40.0f)

#undef	NAV_BUTTON_MIN_HEIGHT
#define	NAV_BUTTON_MIN_HEIGHT	(40.0f)

#undef	NAV_BAR_HEIGHT
#define	NAV_BAR_HEIGHT	(44.0f)


@interface UIButton (Extension)

/** 扩大按钮点击范围 from:http://stackoverflow.com/questions/808503/uibutton-making-the-hit-area-larger-than-the-default-hit-area**/
@property (assign, nonatomic) UIEdgeInsets hitTestEdgeInsets;


- (UIButton *)ydy_initBackBtnWithTarget:(id)target action:(SEL)action;
- (UIButton *)ydy_initLoginBackBtnWithTarget:(id)target action:(SEL)action;
//from EasyiOS
-(UIButton *)initNavigationButton:(UIImage *)image;
-(UIButton *)initNavigationButtonWithTitle:(NSString *)str color:(UIColor *)color;

- (void)ydy_loadBottonBackgroudImageUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)placeImage radius:(CGFloat)radius state:(UIControlState)state isBackgroud:(BOOL )isBG;

- (void)ydy_loadBottonBackgroudImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeImageName radius:(CGFloat)radius state:(UIControlState)state isBackgroud:(BOOL )isBG;

@end
