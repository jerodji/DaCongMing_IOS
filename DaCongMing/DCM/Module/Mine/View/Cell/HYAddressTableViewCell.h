//
//  HYAddressTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYMyAddressModel.h"

@protocol HYAddressBtnActionDelegate <NSObject>

- (void)addressBtnAcitonWithFlag:(NSInteger)flag indexPath:(NSIndexPath *)indexPath;

@end

@interface HYAddressTableViewCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYMyAddressModel *addressModel;

/** delegate */
@property (nonatomic,weak) id<HYAddressBtnActionDelegate>delegate;

/** indexPath */
@property (nonatomic,strong) NSIndexPath *indexPath;

@end
