//
//  FillUnipayInfoView.m
//  DaCongMing
//
//  Created by hailin on 2018/2/2.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "FillUnipayInfoView.h"

@interface FillUnipayInfoView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *bankField;
@property (weak, nonatomic) IBOutlet UITextField *acountField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (nonatomic,strong) NSMutableArray * infoArr;
//@property (nonatomic,assign) CGRect rect;
@end

@implementation FillUnipayInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _infoArr = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@""]];
    
    _bankField.tag = 0;
    _acountField.tag = 1;
    _nameField.tag = 2;
    _phoneField.tag = 3;
    
    _bankField.delegate = self;
    _acountField.delegate = self;
    _nameField.delegate = self;
    _phoneField.delegate = self;
    
    _bankField.placeholder = @"银行卡开户行,如:中国建设银行";
    _acountField.placeholder = @"付款银行卡号";
    _nameField.placeholder = @"您的真实姓名";
    _phoneField.placeholder = @"手机号码";
    
    _bankField.returnKeyType = UIReturnKeyDone;
    _acountField.returnKeyType = UIReturnKeyDone;
    _nameField.returnKeyType = UIReturnKeyDone;
    _phoneField.returnKeyType = UIReturnKeyDone;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    for (int i=0; i<4; i++)
    {
        switch (textField.tag) {
            case 0:
                [_infoArr replaceObjectAtIndex:0 withObject:textField.text];
                break;
            case 1:
                [_infoArr replaceObjectAtIndex:1 withObject:textField.text];
                break;
            case 2:
                [_infoArr replaceObjectAtIndex:2 withObject:textField.text];
                break;
            case 3:
                [_infoArr replaceObjectAtIndex:3 withObject:textField.text];
                break;
                
            default:
                break;
        }
    }
    
    !_infoListCB ? : _infoListCB(_infoArr);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    self.frame = _rect;
//}


@end
