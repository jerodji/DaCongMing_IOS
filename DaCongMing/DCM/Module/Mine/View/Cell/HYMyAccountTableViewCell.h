//
//  HYMyAccountTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@interface HYMyAccountTableViewCell : UITableViewCell

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** headerImgView */
@property (nonatomic,strong) UIImageView *headerImgView;
/** 用户名 */
@property (nonatomic,strong) UILabel *nickNameLabel;

@end
