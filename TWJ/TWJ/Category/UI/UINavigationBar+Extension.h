

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extension)

- (void)ydy_setBackgroundColor:(UIColor *)color;

- (void)ydy_hiddenNavigationBarBottomLine;
// STCreate
- (void)ydy_setBackgroundColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize;

- (void)ydy_setLineBarColorInLogin:(UIColor *)color;

//STCreate 新增优化方法，后期可添加到viewWillDisappear中
- (void)ydy_reset;

@end
