//
//  HYHomeImgCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@interface HYHomeImgCell : UITableViewCell

/** imgUrl */
@property (nonatomic,copy) NSString *imgUrl;

/** img */
@property (nonatomic,strong) UIImageView *imgView;

/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;


@end
