class Config {
  // ignore: non_constant_identifier_names
  static bool DEBUG = false;

  static const PAGE_SIZE = 20;

  /// //////////////////////////////////////常量////////////////////////////////////// ///
  static const API_TOKEN = "4d65e2a5626103f92a71867d7b49fea0";
  static const TOKEN_KEY = "token";
  static const USER_NAME_KEY = "user-name";
  static const PW_KEY = "user-pw";
  static const USER_BASIC_CODE = "user-basic-code";
  static const USER_INFO = "user-info";
  static const LANGUAGE_SELECT = "language-select";
  static const LANGUAGE_SELECT_NAME = "language-select-name";
  static const REFRESH_LANGUAGE = "refreshLanguageApp";
  static const THEME_COLOR = "theme-color";
  static const LOCALE = "locale";

  //api请求地址
  static const String debugbaseURL = "http://localhost:8080"; //测试环境IP
  static const String baseURL = "http://47.96.155.48:4001"; //生产环境IP
  // 上传图片--需要
  static const String uploadFileToOssFront =
      "/wwqbAdmin/base/idcardCheck"; //正面--需要
  static const String uploadFileToOssBack =
      "/wwqbAdmin/base/uploadFileToOss"; //背面--需要

  //埋点--需要
  //public addEventUrl = "http://localhost:8088/record/event/addEvent";//测试环境IP
  static const String addEventUrl = "/wwqbRecord/event/addEvent"; //生产环境

  //现金贷接口路径
  // 银行认证
  static const String bankAuthUrl = "/wwqbAdmin/loanapp/user/bankVerity";
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
  // 登录
  static const String xjdLoginBySmsCodeUrl =
      "/wwqbAdmin/app/appuser/loginBySmsCode"; //需要
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
