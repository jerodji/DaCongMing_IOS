//
//  JJSearchBar.h
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BeginEditingBLK)(void);

@interface JJSearchBar : UIView
@property (nonatomic, copy) BeginEditingBLK beginEditCB;
@end
