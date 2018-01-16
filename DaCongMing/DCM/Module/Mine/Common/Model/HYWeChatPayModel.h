//
//  HYWeChatPayModel.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

/*
 "appid": "wxedc46e1ed9be6e2c",
 "noncestr": "fea6d720bbe24e599a44fcb6216b247a",
 "package": "Sign=WXPay",
 "partnerid": "1482424722",
 "prepayid": "wx201709251735583a820d0bbd0040451182",
 "sign": "242A37892D758F613DE15336042D2717",
 "timestamp": "1506332158"
 */

@interface HYWeChatPayModel : HYBaseModel

/** appid */
@property (nonatomic,copy) NSString *appid;
/** noncestr */
@property (nonatomic,copy) NSString *noncestr;
/** package */
@property (nonatomic,copy) NSString *package;
/** partnerid */
@property (nonatomic,copy) NSString *partnerid;
/** prepayid */
@property (nonatomic,copy) NSString *prepayid;
/** sign */
@property (nonatomic,copy) NSString *sign;
/** timestamp */
@property (nonatomic,assign) UInt32 timestamp;

@end
