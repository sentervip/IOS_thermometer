

#import <UIKit/UIKit.h>
#import "UIButton+Extension.h"

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
-(BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (Extension) <BackButtonHandlerProtocol>

- (void)setLoginNaviBar;

@end
