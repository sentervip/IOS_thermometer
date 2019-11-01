
#import <UIKit/UIKit.h>

@class TWJTimePickerView;
@protocol TWJTimePickerViewDelegate <NSObject>

- (void)XKTimePickerView:(TWJTimePickerView *)timePickerView clickBtnAtIndex:(NSInteger)btnIndex timeData:(NSDate *)tiemData;

@end

@interface TWJTimePickerView : UIView
@property (nonatomic, copy)NSString *title;
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic, weak)id <TWJTimePickerViewDelegate> delegate;

- (instancetype)initWithOkBtnTitle:(NSString *)okBtnTitle
                    cancleBtnTitle:(NSString *)cancleTitle
                          delegate:(id <TWJTimePickerViewDelegate>)delegate;

- (void)showInView:(UIView *)view;

@end
