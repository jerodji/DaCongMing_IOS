//
//  FillUnipayInfoView.h
//  DaCongMing
//
//  Created by hailin on 2018/2/2.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FILLINFOBLK)(NSMutableArray* array);

@interface FillUnipayInfoView : UIView
@property (nonatomic,copy) FILLINFOBLK infoListCB;
@end
