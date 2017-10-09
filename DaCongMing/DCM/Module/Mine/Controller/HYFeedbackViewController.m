//
//  HYFeedbackViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYFeedbackViewController.h"

@interface HYFeedbackViewController () <UITextViewDelegate>

/** textView */
@property (nonatomic,strong) SAMTextView *textView;
/** label */
@property (nonatomic,strong) UILabel *textNumCountLabel;
/** confirmBtn */
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYFeedbackViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = KAPP_WHITE_COLOR;
}


#pragma mark - lazyload
- (SAMTextView *)textView{
    
    if (!_textView) {
        
        _textView = [[SAMTextView alloc] init];
        _textView.placeholder = @"请提出您宝贵的意见，我们会积极改正...";
        _textView.delegate = self;
        _textView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _textView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
