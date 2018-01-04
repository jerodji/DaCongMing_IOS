//
//  HYShareHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShareHandle.h"

@implementation HYShareHandle

+ (void)shareImamgeToWeChatWithDict:(NSDictionary *)dict{
    
    WXMediaMessage *message = [WXMediaMessage message];
    
    
    message.title = @"我的二维码";
    [message setThumbImage:[UIImage imageNamed:@"iconPlaceholder"]];
    WXImageObject *imageObject = [[WXImageObject alloc] init];
    imageObject.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"shareImgUrl"]]];
    message.mediaObject = imageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
}

+ (void)shareToWeChatWithDict:(NSDictionary *)dict{
    
    SendMessageToWXReq *rep = [[SendMessageToWXReq alloc] init];

    WXMediaMessage *message = [WXMediaMessage message];
    message.description = [dict objectForKey:@"shareDesc"];
    message.title = [dict objectForKey:@"shareTitle"];
    
    if ([dict objectForKey:@"shareUrl"]) {
        
        WXWebpageObject *object = [[WXWebpageObject alloc] init];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"imageUrl"]]]];
        [message setThumbImage:image];
        object.webpageUrl = [dict objectForKey:@"shareUrl"];
        message.mediaObject = object;

    }
    
    if ([dict objectForKey:@"shareImgUrl"]) {
        
        WXImageObject *imageObject = [[WXImageObject alloc] init];
        imageObject.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"shareImgUrl"]]];
        message.mediaObject = imageObject;
        rep.bText = NO;
    }
    
    rep.message = message;
    rep.scene = WXSceneSession;
    [WXApi sendReq:rep];
}

+ (void)shareToLifeCircleWithDict:(NSDictionary *)dict{
    
    SendMessageToWXReq *rep = [[SendMessageToWXReq alloc] init];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.description = [dict objectForKey:@"shareDesc"];
    message.title = [dict objectForKey:@"shareTitle"];
    
    if ([dict objectForKey:@"shareUrl"]) {
        
        WXWebpageObject *object = [[WXWebpageObject alloc] init];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"imageUrl"]]]];
        [message setThumbImage:image];
        object.webpageUrl = [dict objectForKey:@"shareUrl"];
        message.mediaObject = object;
        
    }
    
    if ([dict objectForKey:@"shareImgUrl"]) {
        
        WXImageObject *imageObject = [[WXImageObject alloc] init];
        imageObject.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"shareImgUrl"]]];
        message.mediaObject = imageObject;
        rep.bText = NO;
    }
    
    rep.message = message;
    rep.scene = WXSceneTimeline;
    [WXApi sendReq:rep];
}

@end
