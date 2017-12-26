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
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"意见反馈";
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    [self.view addSubview:self.textView];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.textNumCountLabel];
}

- (void)viewDidLayoutSubviews{
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(240 * WIDTH_MULTIPLE);
    }];
    
    [_textNumCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_textView).offset(-5 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_textView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(22);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_textView);
        make.top.equalTo(_textView.mas_bottom).offset(30 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - action
- (void)confirmAction{
    
    if ([self.textView.text isNotBlank]) {
        
        [HYUserHandle userFeedBackWithText:self.textView.text complectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"感谢你的反馈"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

#pragma mark - textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    
    if (range.location >= 300){
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSInteger count = self.textView.text.length;
    NSString *str = [NSString stringWithFormat:@"%ld/300",(long)count];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:@"/300"];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:KAPP_272727_COLOR range:range];
    self.textNumCountLabel.attributedText = attributeStr;
}

#pragma mark - lazyload
- (SAMTextView *)textView{
    
    if (!_textView) {
        
        _textView = [[SAMTextView alloc] init];
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@" 请提出你的宝贵意见。。。。" attributes:@{NSForegroundColorAttributeName : KAPP_272727_COLOR,NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        _textView.attributedPlaceholder = attributeStr;
        _textView.font = KFitFont(16);
        _textView.delegate = self;
        _textView.backgroundColor = KAPP_WHITE_COLOR;
        _textView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}

- (UILabel *)textNumCountLabel{
    
    if (!_textNumCountLabel) {
        
        _textNumCountLabel = [[UILabel alloc] init];
        _textNumCountLabel.font = KFitFont(14);
        _textNumCountLabel.textAlignment = NSTextAlignmentRight;
        _textNumCountLabel.textColor = KAPP_THEME_COLOR;
        _textNumCountLabel.text = @"0/300";
    }
    return _textNumCountLabel;
}


- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        _confirmBtn.titleLabel.font = KFitFont(18);
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
