//
//  HYShareHandle.m
//  DaCongMing
//
//

#import "HYShareHandle.h"
#import "JJTailorManager.h"
#import "UIImage+AttributeImage.h"

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
            UIImage * imag = [UIImage compressOriginalImage:shareModel.image toSize:CGSizeMake(70, 120)];
            [message setThumbImage:imag];
            
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
//            message.thumbData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareModel.urlImg]];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:shareModel.urlImg]]];
            image = [UIImage compressOriginalImage:image toSize:CGSizeMake(50, 50)];/* po [UIImageJPEGRepresentation(image, 1) length]/1024.0 */
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
    NSLog(@"%d",[WXApi sendReq:req]);
}

@end
