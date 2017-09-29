//
//  TabMyController.m
//  vitagou
//
//  Created by Mac on 2017/3/30.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
//  @license The MIT License (MIT)
//


/*
 http://www.vitagou.hk/mobile/app_home (首页)
 public class ApiInterface {
	public static final String VITAGOUURL = "http://www.vitagou.hk/";
	public static String LOGIN_VITAGOU = "http://login.vitagou.com/";
	public static final String VTGAPIURL = "http://api.vitagou.com/";
 //	 public static String LOGIN_VITAGOU = "http://s3.vitagou.com/";// 测试
 //	 public static String VITAGOUURL = "http://s1.vitagou.com/";//
 //	 public static String VTGAPIURL = "http://api.s3.vitagou.com/";
 * 线上地址： http://www.vitagou.hk/mobile/app_alipay_callback 测试机地址：
 * http://s1.vitagou.com/mobile/app_alipay_callback
 
// 支付宝回调接口
public static final String APP_ALIPAYCALLBACK = VITAGOUURL
+ "mobile/app_alipay_callback";
// 获取token
public static final String APP_GETTOKEN = VTGAPIURL + "app/get-token";
public static final String APP_QQLOGIN = VTGAPIURL + "app/qq-login";
public static final String APP_SETQQUSER = VTGAPIURL + "app/set-qq-user";
public static final String APP_WEIBOLOGIN = VTGAPIURL + "app/weibo-login";
public static final String APP_SETWEIBOUSER = VTGAPIURL
+ "app/set-weibo-user";
// 注册协议地址
public static final String Vitagou_link = "www.vitagou.hk/simple/agreement";
// 登陆注册接口替换
public static final String SECRET = "app%fgh165Vb3@";

public static final String APP_CODE_CHANGE = LOGIN_VITAGOU
+ "index.php?r=sms/send";
public static final String APP_SEND_MSM = LOGIN_VITAGOU
+ "index.php?r=sms/send";
public static final String APP_REG_CHANGE = LOGIN_VITAGOU
+ "index.php?r=login/app-register";
// public static final String APP_RESET_PWD =
// "http://login.vitagou.com/index.php?r=app/reset-password";
public static final String APP_RESET_PWD = LOGIN_VITAGOU
+ "index.php?r=app/reset-password";
public static final String APP_GET_TOKEN = LOGIN_VITAGOU
+ "index.php?r=app/get-token"; // 用于忘记密码获取token
// 微信登陆接口
// status返回-1，说明该微信用户未登陆过平台要调用借口获得个人信息
public static final String WEIXIN_LONGIN = LOGIN_VITAGOU
+ "index.php?r=app/weixin-login"; // 测试机
// 保存相关的微信用户信息
public static final String SET_WEIXIN_USER = LOGIN_VITAGOU
+ "index.php?r=app/set-weixin-user";// 测试机

// 商品链接
public static final String GOOD_URL = "http://www.vitagou.hk/products/id/";
public static final String GOOD_URL1 = "http://www.vitagou.hk/site/products1/id/";
// public static final String GOOD_URL =
// "http://s1.vitagou.com/site/products/id/";// 测试站
// ---------------------------------------------------------------------------------------------------------
public static final String LOGIN = VITAGOUURL + "mobile/app_login";
public static final String APP_CODE = VITAGOUURL + "mobile/app_code";
public static final String APP_REG = VITAGOUURL + "mobile/app_reg";
// 图片需加上的前缀
public static final String APP_INFO = VITAGOUURL + "mobile/app_info";
public static final String APP_CLASSIFY = VITAGOUURL
+ "mobile/app_classify";
public static final String APP_TOW_CLASSIFY = VITAGOUURL
+ "mobile/app_tow_classify";
public static final String APP_GOODS_DETAILS = VITAGOUURL
+ "mobile/app_goods_details";
public static final String APP_TIME_SALE = VITAGOUURL
+ "mobile/app_time_sale";
public static final String APP_HOME = VITAGOUURL + "mobile/app_home";
public static final String APP_HOT_SEARCH = VITAGOUURL
+ "mobile/app_hot_search";
public static final String APP_QUERY_JOINCART = VITAGOUURL
+ "mobile/app_query_joinCart";
public static final String APP_ADD_JOINCART = VITAGOUURL
+ "mobile/app_add_joinCart";
public static final String APP_TYPE_SEARCH = VITAGOUURL
+ "mobile/app_type_search";
public static final String APP_DEL_JOINCART = VITAGOUURL
+ "mobile/app_del_joinCart";
public static final String APP_COMPUTE_JOINCART = VITAGOUURL
+ "mobile/app_compute_joinCart";
public static final String APP_SELECTED_JOINCART = VITAGOUURL
+ "mobile/app_selected_joinCart";
public static final String APP_CONFIRM_ORDER = VITAGOUURL
+ "mobile/app_confirm_order";
public static final String APP_PERSONAL_INFO = VITAGOUURL
+ "mobile/app_personal_info";
// app_shop_collection（收藏） goods_id 商品ID或店铺ID type 0为商品 1为店铺
public static final String APP_SHOP_COLLECTION = VITAGOUURL
+ "mobile/app_shop_collection";
// type为1时待付款 2时为待发货 3时为待收货 4待评价 不给type就显示全部
public static final String APP_MY_ORDER = VITAGOUURL
+ "mobile/app_my_order";
public static final String APP_GENERATE_ORDER = VITAGOUURL
+ "mobile/app_generate_order";
// token order_no goods_id contents point fileUpload[]
public static final String APP_ADD_COMMENTS = VITAGOUURL
+ "mobile/app_add_comments";
public static final String APP_ADD_ADDRESS = VITAGOUURL
+ "mobile/app_add_address";
public static final String APP_DEFAULT_ADDRESS = VITAGOUURL
+ "mobile/app_default_address";
public static final String APP_ORDER_STATUS = VITAGOUURL
+ "mobile/app_order_status";
public static final String APP_DEL_ADDRESS = VITAGOUURL
+ "mobile/app_del_address";
public static final String APP_UP_ADDRESS = VITAGOUURL
+ "mobile/app_up_address";
public static final String APP_MY_ADDRESS = VITAGOUURL
+ "mobile/app_my_address";
public static final String APP_COUNPONS = VITAGOUURL
+ "mobile/app_counpons";
public static final String APP_TICKET_MONEY = VITAGOUURL
+ "mobile/app_ticket_money";
// status , order_no
public static final String APP_CHANGE_ORDER = VITAGOUURL
+ "mobile/app_change_order";
public static final String APP_VERSION = VITAGOUURL + "mobile/app_version";
public static final String APP_RECOMMEND_GOODS = VITAGOUURL
+ "mobile/app_recommend_goods ";
public static final String APP_CHANGE_PWD = VITAGOUURL
+ "mobile/app_change_pwd";
public static final String APP_GOODS_COMMENT = VITAGOUURL
+ "mobile/app_goods_comment";// 参数goods_id
public static final String APP_MY_COMMENTS = VITAGOUURL
+ "mobile/app_my_comments";// 参数user_token
public static final String APP_ORDER_DETAILS = VITAGOUURL
+ "mobile/app_order_details";
public static final String APP_CANCEL_ORDER = VITAGOUURL
+ "mobile/app_cancel_order";
public static final String APP_MY_FOOTPRINT = VITAGOUURL
+ "mobile/app_my_footprint";
public static final String APP_DEL_FOOTPRINT = VITAGOUURL
+ "mobile/app_del_footprint";
public static final String APP_MY_GOODS = VITAGOUURL
+ "mobile/app_my_goods";
public static final String APP_MY_SHOP = VITAGOUURL + "mobile/app_my_shop";
public static final String APP_DEL_COLLECTION = VITAGOUURL
+ "mobile/app_del_collection";
public static final String APP_WECHAT_PAY = VITAGOUURL
+ "mobile/app_weChat_pay";
public static final String APP_UPDATA_INFO = VITAGOUURL
+ "mobile/app_updata_info";
// params order_id;
public static final String APP_DELETE_ORDER = VITAGOUURL
+ "mobile/app_delete_order";
// 在服务端生成相关参数
public static final String APP_GET_ALIPAY_PARAMS = VITAGOUURL
+ "mobile/app_get_alipay_params";
public static final String APP_LOGISTIC_GET = VITAGOUURL
+ "mobile/app_delivary";
// 申请售后
public static final String APP_REFUND = VITAGOUURL + "mobile/app_refund";

// 单个申请售后状态
public static final String APP_REFUND_STATUS = VITAGOUURL
+ "mobile/app_refund_status";
//售后相关状态
public static final String APP_AGREE_REFUND = VITAGOUURL
+ "mobile/app_agree_refund";
// 多个申请售后状态
public static final String APP_MY_REFUND = VITAGOUURL
+ "mobile/app_my_refund";
// 取消售后申请
public static final String APP_DEL_REFUND = VITAGOUURL
+ "mobile/app_del_refund";
//修改申请售后
public static final String APP_REFUND_UPDATE = VITAGOUURL
+ "mobile/app_refund_update";
public static final String APP_WRITE_FREGIHT = VITAGOUURL
+ "mobile/app_write_fregiht";
public static final String APP_COMPLAIN_ADD = VITAGOUURL
+ "mobile/app_complain_add";
}
 */


#define VITAGOUURL @"http://www.vitagou.hk/"
//#define VITAGOUURL @"http://s1.vitagou.com/"

//#define VITAGOUURL @"http://api.s3.vitagou.com/"
//首页
#define APP_HOME VITAGOUURL@"mobile/app_home"
//详情
#define APP_GOODS_DETAILS VITAGOUURL@"mobile/app_goods_details"
//分类
#define APP_CLASSIFY VITAGOUURL@"mobile/app_classify"
#define APP_TWO_CLASSIFY VITAGOUURL@"mobile/app_tow_classify"//接口这边拼错单词
//搜索  显示热门标签
#define APP_HOT_SEARCH VITAGOUURL@"mobile/app_hot_search"
//搜索 接口里面有联合搜索和品牌，分类，商品搜索，只用了后三个(没有联合搜索就跟type无关）
#define APP_TYPE_SEARCH VITAGOUURL@"mobile/app_type_search"

//购物车  参数：user_token
#define APP_QUERY_JOINCART VITAGOUURL@"mobile/app_query_joincart"

#define APP_ADD_JOINCART VITAGOUURL@"mobile/app_add_joinCart"

#define APP_DEL_JOINCART VITAGOUURL@"mobile/app_del_joinCart"

#define APP_COMPUTE_JOINCART VITAGOUURL@"mobile/app_compute_joinCart"

#define APP_SELECTED_JOINCART VITAGOUURL@"mobile/app_selected_joinCart"
//评论 params type ， goods_id
#define APP_GOODS_COMMENT VITAGOUURL@"mobile/app_goods_comment"












//------------------------------------------------------------------------------------------
//网站地址
/*
#define kUrlBase @"http://local.eleteamapi.ygcr8.com/v1" //本地地址
*/
 #define kUrlBase                        @"http://eleteamapi.ygcr8.com/v1" //在线服务器
#define kUrlCategoryListWithProduct     kUrlBase@"/category/list-with-product"
#define kUrlCategoryList                kUrlBase@"/app/category/list"
//#define kUrlCategoryListWithProduct     kUrlBase@"/app/category/list-with-product"
#define kUrlProduct                     kUrlBase@"/product/view?id=%@"

//查看打折的商品列表
#define kUrlGetFeaturedProducts         kUrlBase@"/product/list-featured-price"
//为你精选的商品列表
#define kUrlGetTopicProducts            kUrlBase@"/product/list-featured-topic"
//销量最高的商品列表
#define kUrlGetTopSaleProducts          kUrlBase@"/product/list-top-seller"

//购物车
#define kUrlGetCart                     kUrlBase@"/cart"
//添加购物车项
#define kUrlCartAdd                     kUrlBase@"/cart/add"
//设置购物车项的数量
#define kUrlSetCartItemCountWithItemId  kUrlBase@"/app/cart/setCartItemNum/%@"
//删除购物车项
#define kUrlCartItemDelete              kUrlBase@"/cart-item/delete?id=%@"
//选取购物车项
#define kUrlSelectCartItemWithItemId    kUrlBase@"/app/cart/setIsSelected/%@"

//从购物车添加预购订单
#define kUrlPreorderAdd                 kUrlBase@"/preorder/create"
//获取预购订单
#define kUrlPreorderWithId              kUrlBase@"/preorder/view?id=%@"
//设置支付方式
#define kUrlPreorderSetPayType          kUrlBase@"/preorder/set-pay-type"

//添加收货地址
#define kUrlAddressAdd                  kUrlBase@"/address/create"
//修改收货地址
#define kUrlAddressEditWithId           kUrlBase@"/address/update?id=%@"
//获得地址列表
#define kUrlAddressGetList              kUrlBase@"/address"
//设置默认地址
#define kUrlAddressSetDefaultWithId     kUrlBase@"/address/set-default?id=%@"
//获得系统默认的区域信息
#define kUrlAreaPrefixChainedAreas      kUrlBase@"/area/find-prefix-area-chained-areas"

//提交订单
#define kUrlOrderAddWithPreorderId      kUrlBase@"/order/create?preorder_id=%@"
//查看订单
#define kUrlOrderViewWithId             kUrlBase@"/order/view?id=%@"
//获取订单列表
#define kUrlOrderList                   kUrlBase@"/order"
//获取待付款订单列表
#define kUrlOrderListPendingPay         kUrlBase@"/order/list-pending-pay"
//获取待收货订单列表
#define kUrlOrderListDelivering         kUrlBase@"/order/list-delivering"
//获取交易完成订单列表
#define kUrlOrderListFinished           kUrlBase@"/order/list-finished"

//获取用户信息
#define kUrlUserGet                     kUrlBase@"/user/view"
//注册 - 提交手机号码
#define kUrlUserRegisterStep1       kUrlBase@"/user/register-step1"
//注册 - 提交手机号码、密码
#define kUrlUserRegisterStep2       kUrlBase@"/user/register-step2"
//注册 - 提交手机号码、密码、验证码
#define kUrlUserRegisterStep3       kUrlBase@"/user/register-step3"
//重置密码 - 提交手机号码
#define kUrlUserForgetPasswordStep1Post kUrlBase@"/app/user/forget-password-step1-post"
//重置密码 - 提交手机号码和密码
#define kUrlUserForgetPasswordStep2Post kUrlBase@"/app/user/forget-password-step2-post"
//重置密码 - 提交手机号码、密码、验证码
#define kUrlUserForgetPasswordStep3Post kUrlBase@"/app/user/forget-password-step3-post"
//登录
#define kUrlUserLogin                   kUrlBase@"/user/login"
//退出登录
#define kUrlUserLogout                  kUrlBase@"/user/logout"


