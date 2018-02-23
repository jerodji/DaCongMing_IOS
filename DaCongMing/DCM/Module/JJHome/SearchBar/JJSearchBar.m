//
//  JJSearchBar.m
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "JJSearchBar.h"

@interface JJSearchBar()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *shdowView;
//@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *ssBtn;
@property (nonatomic, copy) NSString * searchStr;
@end

@implementation JJSearchBar

- (IBAction)textBtn:(id)sender {
//    !_beginEditCB ? : _beginEditCB();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.alpha = 0.5;
//    self.layer.shadowRadius = 13;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOpacity = 0.6;
//    self.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    
//    self.shdowView.layer.cornerRadius = 13;
    
    
    
    [_ssBtn addTarget:self action:@selector(ssAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    _textField.delegate = self;
//    _textField.returnKeyType = UIReturnKeySearch;
//    [_textField addTarget:self action:@selector(searchTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)ssAction:(UIButton*)button {
//    [_textField resignFirstResponder];
//    if (NotNull(_searchStr)) {
//        !_ssCB ? : _ssCB(_searchStr);
//    }
    NSLog(@"ss");
    !_beginEditCB ? : _beginEditCB();
}

//- (void)searchTextFieldDidChange:(UITextField*)theTextField {
//    _searchStr = theTextField.text;
//}

//#pragma mark - textField delegate
////- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
////
////}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    NSLog(@"开始搜索");
//    return YES;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
////    !_beginEditCB ? : _beginEditCB();
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    NSLog(@"%@",textField.text);
//}




@end
