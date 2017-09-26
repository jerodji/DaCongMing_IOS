
//
//  WebApi.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#ifndef WebApi_h
#define WebApi_h

#define WXAppID                 @"wxedc46e1ed9be6e2c"

/** ------------------------------网络接口------------------------------- */
//接口总域名
#define API_DomainStr           @"http://www.laopdr.cn"

//#define API_DomainStr           @"http://www.huakr.com"

//首页接口
#define API_HomePage            @"HAILIN_SERVER/showMenu.do"

//分类
#define API_Sort                @"HAILIN_SERVER/showType.do"

/********************************用户相关*********************************/
//登录
#define API_Login               @"HAILIN_SERVER/userlogin.do"

//微信登录
#define API_WeChatLogin         @"HAILIN_SERVER/wechatLogin.do"

//获取验证码
#define API_GetAuthCode         @"HAILIN_SERVER/getPhoneCode.do"

//验证手机验证码
#define API_VerifyAuthCode        @"HAILIN_SERVER/checkPhoneCode.do"

//设置密码
#define API_SetPassword           @"HAILIN_SERVER/setUserPwd.do"

/********************************订单相关*********************************/
//购物车
#define API_ShoppingCart        @"HAILIN_SERVER/showCart.do"

//商品列表
#define API_GoodsList           @"HAILIN_SERVER/loaditemMsg.do"

//商品详情
#define API_GoodsDetail         @"HAILIN_SERVER/loaditemDetail.do"

//创建订单
#define API_CreateOrder         @"HAILIN_SERVER/getSellerOrder.do"

//支付宝支付
#define API_Alipay              @"HAILIN_PAY/getAliPayOrder.do"

//微信支付
#define API_WeChatPay              @"HAILIN_PAY/getWechatPayOrder.do"

#endif /* WebApi_h */
