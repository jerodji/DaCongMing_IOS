//
//  JJHotInStoreView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/24.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTableModel.h"

@interface JJHotInStoreView : UIView
@property (nonatomic, strong) JJTableModel* tableModel;
- (void)setupStoreLabelDataWith:(NSString*)store LTD:(NSString*)ltdName;
@end
