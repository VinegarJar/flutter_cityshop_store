class Config {
  static const bool DEBUG = true;
  static const PAGE_SIZE = 20;
  static const TOKEN_KEY = "token";
  static const USER_INFO = "userInfo";
  static const USER_VIP = "vipLevel";

  //api请求地址
  static const String baseURL = "http://121.40.252.174:6001";

  //埋点
  static const String addEventUrl = "/record/event/addEvent";
  // 登录
  static const String loginUrl = "/szgjadmin/app/appuser/loginNoRegister";
  //首页贷款列表-特别推荐
  static const String homeBankUrl = "/szgjadmin/app/product/getRecommed";
  //首页今日推荐
  static const String todayRecommed =
      "/szgjadmin/app/product/getNewTodayRecommed";
  //新口子推荐
  static const String productRecommed = "/szgjadmin/app/product/getRecommed";
  //用户信息
  static const String userInfo = "/szgjadmin/app/appuser/getAppUserInfo";
  // 实名制信息认证
  static const String userRealCheck = "/szgjadmin/app/appuser/userRealCheck";

  //获取产品地址
  static const String productUr = "/szgjadmin/app/product/getProductUrlById";

  //支付
  static const String payVip = "/szgjadmin//app/appuser/payVip";
  // 支付的-appid2021002194675872

  //获取权益
  static const String getAppShowConfig =
      "/szgjadmin/app/appconfig/getAppShowConfig";

  //获取会员专享
  static const String getVipProductList =
      "/szgjadmin/app/product/getVipProductList";

  // 上传图片--需要
  static const String uploadFileToOssFront =
      "/wwqbAdmin/base/idcardCheck"; //正面--需要
  static const String uploadFileToOssBack =
      "/wwqbAdmin/base/uploadFileToOss"; //背面--需要

  //现金贷接口路径
  // 基本信息认证
  static const String basicInfoUrl = "/wwqbAdmin/loanapp/user/basicInfoVerify";
  // 获得用户验证信息
  static const String getAuthInfoUrl =
      "/wwqbAdmin/loanapp/user/getLoanUserVerifyInfo";
  // 发送短信验证码
  static const String xjdSendSmsCodeUrl =
      "/wwqbAdmin/app/appuser/appSmsCode"; //需要
  // 运营商认证
  static const String operatorAuthUrl =
      "/wwqbAdmin/loanapp/user/phoneOperatorsVerity";
  // 上传实名认证信息
  static const String xjdSaveRealInfoUrl =
      "/wwqbAdmin/app/appuser/saveRealInfo"; //需要

  // 获取用户信息
  static const String userinfo = "/wwqbAdmin/app/appuser/getAppUserInfo"; //需要
  // 获取用户借款记录
  static const String loanRecord = "/wwqbAdmin/loanapp/app/getXdjUserLoanInfo";
  // 添加记录
  static const String record = "/wwqbAdmin/loanapp/app/insertRecord";
  // 获取所关联的客服信息
  static const String friendIdByPhoneNum =
      "/wwqbAdmin/loanapp/app/getFriendIdByPhoneNum";
  // 获取支付二维码
  static const String payLink = "/wwqbAdmin/app/appconfig/getPayType";
  // 获取借款详情
  static const String loanDetail = "/wwqbAdmin/loanapp/app/getLoanDetail";
  // 查看用户认证信息
  static const String basicInfo2 = "/wwqbAdmin/loanapp/user/getBasicInfo";
  // 贷款大全列表
  static const String getJqbListUrl = "/wwqbAdmin/app/product/getJqbList";
  // 获取今日推荐区域数据
  static const String getTodayRecommedUrl =
      "/wwqbAdmin/app/product/getNewTodayRecommed";
  // 获取审核状态
  static const String getApprovalStatusUrl =
      "/wwqbAdmin/app/appuser/getUserStatus";

  // 新增投诉信息
  static const String addComplaintUrl = "/wwqbAdmin/app/appuser/addComplaint";

  // 判断用户是否可以弹窗
  static const String isShowDialogUrl = "/wwqbAdmin/app/product/getUserWindown";
  // 获取弹窗产品
  static const String getDialogProdUrl =
      "/wwqbAdmin/app/product/getWindowProductNew";
}
