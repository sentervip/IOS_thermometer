

#import <UIKit/UIKit.h>

@class TWJTableViewCell;
@protocol YDYTableViewCellDelegate <NSObject>

@optional
- (void)clickTableViewCellBtn:(UIButton *)btn cell:(TWJTableViewCell *)cell;

- (void)clickTableViewCellWithIndexPath:(NSIndexPath *)IndexPath :(NSString *)className;

- (void)clickTableViewCellBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;

@end

@interface TWJTableViewCell : UITableViewCell 

@property (nonatomic,strong) UIView * lineView;
@property (weak, nonatomic) id<YDYTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)commonInit __attribute((objc_requires_super));
- (void)addAutoLayout;
- (void)reloadEntity:(id)entity;
- (void)reloadEntity:(id)entity sender:(id)sender;



@end
