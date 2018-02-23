//
//  HYSystemMessageModel.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>

@interface HYSystemMessageModel : NSObject


//@property (nonatomic,copy) NSString *msg;
//@property (nonatomic,copy) NSString *recomMsg;
//@property (nonatomic,copy) NSString *recomer_name;
//@property (nonatomic,copy) NSString *stat;
//@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString * close_time;
@property (nonatomic,copy) NSString * create_time;
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * msg;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * receive_bank_name;
@property (nonatomic,copy) NSString * receive_bankcard_id;
@property (nonatomic,copy) NSString * receiver_name;
@property (nonatomic,copy) NSString * recomMsg;
@property (nonatomic,copy) NSString * recomer_id;
@property (nonatomic,copy) NSString * recomer_name; /* 推荐人 */
@property (nonatomic,copy) NSString * recomer_phone;
@property (nonatomic,copy) NSString * recomlevel;
@property (nonatomic,copy) NSString * stat;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * user_id;

@end

/**
 {
     "close_time" = "2018-02-02 17:21:21.0";
     "create_time" = "2018-01-30 17:21:21.0";
     id = 110;
     msg = "\U652f\U4ed8\U540e\U52a0\U5165\U5927\U806a\U660e";
     price = 2;
     "receive_bank_name" = "\U4e2d\U56fd\U5efa\U8bbe\U94f6\U884c\U80a1\U4efd\U6709\U9650\U516c\U53f8\U4e0a\U6d77\U5e7f\U5bcc\U6797\U8def\U652f\U884c";
     "receive_bankcard_id" = 31050180480000000238;
     "receiver_name" = "\U4e0a\U6d77\U8428\U62dc\U7535\U5b50\U5546\U52a1\U6709\U9650\U516c\U53f8";
     recomMsg = "\U5927\U806a\U660e\U9ad8\U7ea7\U5408\U4f19\U4eba";
     "recomer_id" = "o-13Mv0oIXWCKKv9jpe5Ra59R9gY";
     "recomer_name" = "_Levy";
     "recomer_phone" = 15800775573;
     recomlevel = V5;
     stat = 0;
     title = "\U5927\U806a\U660e\U9ad8\U7ea7\U5408\U4f19\U4eba\U63a8\U8350";
     type = AGENT;
     "user_id" = "o-13Mv3pdaihECi3-30cWamAWWGg";
 }
 */
