//
//  HYShareHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShareHandle.h"

@implementation HYShareHandle

+ (void)shareToWeChatWithDict:(NSDictionary *)dict{
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.description = [dict objectForKey:@"shareDesc"];
    message.title = [dict objectForKey:@"shareTitle"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"shareUrl"]]]];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
    UIImage *shareImg = [UIImage imageWithData:imgData];
    [message setThumbImage:shareImg];
    
    WXWebpageObject *object = [[WXWebpageObject alloc] init];
    object.webpageUrl = [dict objectForKey:@"shareUrl"];
    message.mediaObject = object;
    
    SendMessageToWXReq *rep = [[SendMessageToWXReq alloc] init];
    rep.message = message;
    rep.scene = WXSceneSession;
    [WXApi sendReq:rep];
}

+ (void)shareToLifeCircleWithDict:(NSDictionary *)dict{
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.description = [dict objectForKey:@"shareDesc"];
    message.title = [dict objectForKey:@"shareTitle"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"shareUrl"]]]];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
    UIImage *shareImg = [UIImage imageWithData:imgData];
    [message setThumbImage:shareImg];
    
    WXWebpageObject *object = [[WXWebpageObject alloc] init];
    object.webpageUrl = [dict objectForKey:@"shareUrl"];
    message.mediaObject = object;
    
    SendMessageToWXReq *rep = [[SendMessageToWXReq alloc] init];
    rep.message = message;
    rep.scene = WXSceneTimeline;
    [WXApi sendReq:rep];
}

@end
