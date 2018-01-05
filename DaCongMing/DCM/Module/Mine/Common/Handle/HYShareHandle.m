//
//  HYShareHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShareHandle.h"

@implementation HYShareHandle

+ (void)shareToWechatWithModel:(HYShareModel *)shareModel{
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    switch (shareModel.shareType) {
        case HYShareTypeText:{
            req.text = shareModel.text;
            req.bText = YES;
        }
            break;
        case HYShareTypeImage:{
            WXMediaMessage *message = [WXMediaMessage message];
            [message setThumbImage:shareModel.thumbnailImage];
            WXImageObject *imageObject = [WXImageObject object];
            imageObject.imageData = UIImagePNGRepresentation(shareModel.image);
            message.mediaObject = imageObject;
            req.bText = NO;
            req.message = message;
        }
            break;
        case HYShareTypeWebUrl:{
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = shareModel.shareTitle;
            message.description = shareModel.shareDescription;
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:shareModel.shareWebUrl]]];
            [message setThumbImage:image];
            
            WXWebpageObject *object = [WXWebpageObject object];
            object.webpageUrl = shareModel.shareWebUrl;
            message.mediaObject = object;
            req.message = message;
        }
            break;
        default:
            break;
    }
    
    if (shareModel.shareScene == HYShareSceneSession) {
        //分享到好友
        req.scene = WXSceneSession;
    }
    
    if (shareModel.shareScene == HYShareSceneTimeline) {
        //分享到朋友圈
        req.scene = WXSceneTimeline;
    }
    [WXApi sendReq:req];
    DLog(@"%d",[WXApi sendReq:req]);
}

@end
