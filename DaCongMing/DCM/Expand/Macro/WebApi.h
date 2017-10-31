
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
#define TencentBuglyID          @"fee8e3dbb9"
#define QIYUAPPID               @"c8f8ca70f45342c288cb2e23e0c6b600"

/** ------------------------------网络接口------------------------------- */
//接口总域名
#define API_DomainStr           @"http://www.laopdr.cn"

//#define API_DomainStr           @""

//首页接口
#define API_HomePage            @"HAILIN_SERVER/showMenu.do"

//分类
#define API_Sort                @"HAILIN_SERVER/showType.do"

/********************************用户相关*********************************/
#pragma mark - 用户相关
//登录
#define API_Login               @"HAILIN_SERVER/userlogin.do"

//退出登录
#define API_Logout               @"HAILIN_SERVER/userLoginOut.do"

//微信登录
#define API_WeChatLogin         @"HAILIN_SERVER/wechatLogin.do"

//获取验证码
#define API_GetAuthCode         @"HAILIN_SERVER/getPhoneCode.do"

//验证手机验证码
#define API_VerifyAuthCode        @"HAILIN_SERVER/checkPhoneCode.do"

//设置密码
#define API_SetPassword           @"HAILIN_SERVER/setUserPwd.do"

//用户分享
#define API_UserShare             @"HAILIN_SERVER/userShare.do"

//用户反馈
#define API_UserFeedback             @"HAILIN_SERVER/userfeedback.do"

//获取用户购物车收藏数量
#define API_GetUserInfo             @"HAILIN_SERVER/getUserInfo.do"

//获取我的收藏店铺
#define API_GetCollectShop          @"HAILIN_SERVER/getSellerFavorite.do"

//获取我的售后
#define API_GetMySellAfter       @"HAILIN_SERVER/getRefOrderListByStat.do"


/********************************订单相关*********************************/
#pragma mark - 订单相关
//购物车
#define API_ShoppingCart        @"HAILIN_SERVER/showCart.do"

//商品列表
#define API_GoodsList           @"HAILIN_SERVER/loaditemMsg.do"

//商品详情
#define API_GoodsDetail         @"HAILIN_SERVER/loaditemDetail.do"

//所有的评论详情
#define API_AllComments        @"HAILIN_SERVER/loadItemEvaluate.do"

//创建订单
#define API_CreateOrder         @"HAILIN_SERVER/getSellerOrder.do"

//重复下单
#define API_CreateOrderWithOrderID         @"HAILIN_SERVER/rebuySellerOrder.do"

//支付宝支付
#define API_Alipay              @"HAILIN_PAY/getAliPayOrder.do"

//微信支付
#define API_WeChatPay           @"HAILIN_PAY/getWechatPayOrder.do"

//获取所有订单数据
#define API_MyAllOrder          @"HAILIN_SERVER/getSellerOrderList.do"

//获取订单详情
#define API_MyAllOrderDetail          @"HAILIN_SERVER/getSellerOrderBySid.do"

//根据状态获取订单数据
#define API_MyOrderByState          @"HAILIN_SERVER/getSellerOrderByStat.do"

//修改订单收货地址
#define API_ChangeOrderReceiveAddress   @"HAILIN_SERVER/editSellerOrderAddress.do"

//获取优惠券
#define API_MyDiscountConpon         @"HAILIN_SERVER/showUserCoupon.do"

//删除订单
#define API_DeleteOrder             @"HAILIN_SERVER/deleteOrder.do"

//确认收货
#define API_ConfirmReceiveProduct             @"HAILIN_SERVER/confirmReceipt.do"

//关键字搜索
#define API_KeywordsSearch          @"HAILIN_SERVER/searchItem.do"

//退款申请
#define API_SubmitApplySellAfter             @"HAILIN_SERVER/refundforAli.do"

//获取退款详情
#define API_GetRefundDetail                 @"HAILIN_SERVER/getRefOrderDetailByRefOrderID.do"

//提交退款发货信息
#define API_SubmitRefundLogisticsInfo       @"HAILIN_SERVER/sendItemForRefOrder.do"

//评价订单
#define API_CommentOrder                    @"HAILIN_SERVER/orderEvaluate.do"

//物流详情
#define API_GetLogisticUrl                    @"HAILIN_SERVER/getOrderExpressInfo.do"
/***************************************收货地址**********************************/
#pragma mark - 收货地址
//获取收货地址
#define API_MyReceiverAddress         @"HAILIN_SERVER/getAddresses.do"

//收货地址城市数据
#define API_CityData                @"HAILIN_SERVER/getArea.do"

//添加收货地址
#define API_AddReceiveAddress       @"HAILIN_SERVER/addAddress.do"

//编辑收货地址
#define API_EditReceiveAddress       @"HAILIN_SERVER/updateAddress.do"

//设置默认收货地址
#define API_setDefaultReceiveAddress       @"HAILIN_SERVER/changeDfAddress.do"

//删除收货地址
#define API_deleteReceiveAddress       @"HAILIN_SERVER/removeAddress.do"

//编辑收货地址
#define API_editReceiveAddress       @"HAILIN_SERVER/updateAddress.do"

#pragma mark - 购物车
//查看购物车
#define API_ShowShppingCarts      @"HAILIN_SERVER/showCart.do"

//添加到购物车
#define API_AddToShoppingCarts      @"HAILIN_SERVER/putCart.do"

//添加到收藏
#define API_AddToCollectGoods      @"HAILIN_SERVER/addItemFavorite.do"

//移除收藏
#define API_RemoveCollectGoods      @"HAILIN_SERVER/removeItemFavorite.do"

//获取收藏
#define API_GetCollectGoods      @"HAILIN_SERVER/getItemFavorite.do"

//移除购物车
#define API_RemoveShoppingCarts     @"HAILIN_SERVER/removeCartItem.do"

//批量修改购物车
#define API_BulkEditShoppingCarts     @"HAILIN_SERVER/editCart.do"

//计算购物车价格
#define API_CalculateCartsAmount       @"HAILIN_SERVER/getCartAmount.do"

//购物车结算
#define API_SettleShoppingCarts       @"HAILIN_SERVER/getSellerOrderByCart.do"

//移除购物车
#define API_DeleteShoppingCarts     @"HAILIN_SERVER/removeCartItem.do"

/***************************************店铺**********************************/
#pragma mark - 店铺
//店铺主页
#define API_ShopHomePage       @"HAILIN_SERVER/showStore.do"

//店铺商品列表
#define API_ShopProductsList       @"HAILIN_SERVER/loaditemMsgInStore.do"

//收藏店铺
#define API_CollectShop       @"HAILIN_SERVER/addSellerFavorite.do"

//取消收藏店铺
#define API_CancelCollectShop       @"HAILIN_SERVER/removeSellerFavorite.do"


#endif /* WebApi_h */
