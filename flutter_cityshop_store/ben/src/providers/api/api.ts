// import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { Http,Response,Headers,RequestOptions} from '@angular/http';
// import { Storage } from "@ionic/storage";
import { GlobalData } from '../globalData';
 
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
 
 
/*
  Generated class for the RestProvider provider.
  See https://angular.io/guide/dependency-injection for more info on providers
  and Angular DI.
*/
@Injectable()
export class ApiProvider {
  public headers: any;
  constructor(public http: Http,
              // public storage: Storage,
              public globalData: GlobalData) {
    // console.log('Hello RestProvider Provider');
  }
  //  public baseURL = "http://localhost:8080";//测试环境IP
  public baseURL = "http://47.96.155.48:4001";//生产环境IP

  // 上传图片--需要
  public uploadFileToOssFront = `${this.baseURL}/wwqbAdmin/base/idcardCheck`//正面--需要
  public uploadFileToOssBack = `${this.baseURL}/wwqbAdmin/base/uploadFileToOss`//背面--需要

  //埋点--需要
  //  public addEventUrl = "http://localhost:8088/record/event/addEvent";//测试环境IP
  private addEventUrl = `http://47.96.155.48:5001/wwqbRecord/event/addEvent`//生产环境

  //现金贷接口路径
  // 银行认证
  private bankAuthUrl = `${this.baseURL}/wwqbAdmin/loanapp/user/bankVerity`
  // 基本信息认证
  private basicInfoUrl = `${this.baseURL}/wwqbAdmin/loanapp/user/basicInfoVerify`
  // 获得用户验证信息
  private getAuthInfoUrl = `${this.baseURL}/wwqbAdmin/loanapp/user/getLoanUserVerifyInfo`
  // 发送短信验证码
  private xjdSendSmsCodeUrl = `${this.baseURL}/wwqbAdmin/app/appuser/appSmsCode`//需要
  // 运营商认证
  private operatorAuthUrl = `${this.baseURL}/wwqbAdmin/loanapp/user/phoneOperatorsVerity`
  // 上传实名认证信息
  private xjdSaveRealInfoUrl = `${this.baseURL}/wwqbAdmin/app/appuser/saveRealInfo`//需要
  // 登录
  private xjdLoginBySmsCodeUrl = `${this.baseURL}/wwqbAdmin/app/appuser/loginBySmsCode`//需要
  // 获取用户信息
  private userinfo = `${this.baseURL}/wwqbAdmin/app/appuser/getAppUserInfo`//需要
  // 获取用户借款记录
  private loanRecord = `${this.baseURL}/wwqbAdmin/loanapp/app/getXdjUserLoanInfo`
  // 添加记录
  private record = `${this.baseURL}/wwqbAdmin/loanapp/app/insertRecord`
  // 获取所关联的客服信息
  private friendIdByPhoneNum = `${this.baseURL}/wwqbAdmin/loanapp/app/getFriendIdByPhoneNum`
  // 获取支付二维码
  private payLink = `${this.baseURL}/wwqbAdmin/app/appconfig/getPayType`
  // 获取借款详情
  private loanDetail = `${this.baseURL}/wwqbAdmin/loanapp/app/getLoanDetail`
  // 查看用户认证信息
  private basicInfo2 = `${this.baseURL}/wwqbAdmin/loanapp/user/getBasicInfo`
  // 贷款大全列表
  private getJqbListUrl = `${this.baseURL}/wwqbAdmin/app/product/getJqbList`//需要
  // 获取今日推荐区域数据
  private getTodayRecommedUrl = `${this.baseURL}/wwqbAdmin/app/product/getNewTodayRecommed`//需要
  // 获取审核状态
  private getApprovalStatusUrl = `${this.baseURL}/wwqbAdmin/app/appuser/getUserStatus`//需求


   // 新增投诉信息
   private addComplaintUrl = `${this.baseURL}/wwqbAdmin/app/appuser/addComplaint`

  // 判断用户是否可以弹窗
  private isShowDialogUrl = `${this.baseURL}/wwqbAdmin/app/product/getUserWindown` //需求
  // 获取弹窗产品
  private getDialogProdUrl = `${this.baseURL}/wwqbAdmin/app/product/getWindowProductNew`//需要


  
  isShowDialog(data):Observable<string[]>{
    return this.getUrlPostReturn(this.isShowDialogUrl, data)
  }
  //
  getDialogProd(data):Observable<string[]>{
    return this.getUrlPostReturn(this.getDialogProdUrl, data)
  }
  // 获取审核状态
  getApprovalStatus(data):Observable<string[]>{
    return this.getUrlPostReturn(this.getApprovalStatusUrl, data)
  }
  // 获取今日推荐区域
  getTodayRecommed(data):Observable<string[]>{
    return this.getUrlPostReturn(this.getTodayRecommedUrl, data)
  }
  // 贷款大全
  getJqbList(data):Observable<string[]>{
    return this.getUrlPostReturn(this.getJqbListUrl, data)
  }
  // 新增投诉信息
  addComplaint(data):Observable<string[]>{
    return this.getUrlPostReturn(this.addComplaintUrl, data)
  }
  //埋点
  addEvent(data):Observable<string[]>{
    return this.getUrlPostReturn(this.addEventUrl, data)
  }
  // 获取支付二维码
  getPayLink(data):Observable<string[]>{
    return this.getUrlPostReturn(this.payLink, data)
  }
  // 获取借款详情
  getLoanDetail(data):Observable<string[]>{
    return this.getUrlPostReturn(this.loanDetail, data)
  }
  // 
  getBasicInfo(data):Observable<string[]>{
    return this.getUrlPostReturn(this.basicInfo2, data)
  }
  // 获取所关联的客服信息
  getFriendIdByPhoneNum(data):Observable<string[]>{
    return this.getUrlPostReturn(this.friendIdByPhoneNum, data)
  }
  // 获取用户信息
  getUserinfo(data):Observable<string[]>{
    return this.getUrlPostReturn(this.userinfo, data)
  }
  // 获取用户借款记录
  getLoanRecord(data):Observable<string[]>{
    return this.getUrlPostReturn(this.loanRecord, data)
  }
  // 添加记录
  insertRecord(data):Observable<string[]>{
    return this.getUrlPostReturn(this.record, data)
  }
  // 发送验证码
  xjdSendSmsCode(data):Observable<string[]>{
    return this.getUrlPostReturn(this.xjdSendSmsCodeUrl, data)
  }
  // 银行认证
  bankAuth(data):Observable<string[]>{
    return this.getUrlPostReturn(this.bankAuthUrl, data)
  }
  // 基本信息认证
  basicInfo(data):Observable<string[]>{
    return this.getUrlPostReturn(this.basicInfoUrl, data)
  }
  // 获取用户验证信息
  getAuthInfo(data):Observable<string[]>{
    return this.getUrlPostReturn(this.getAuthInfoUrl, data)
  }
  // 运营商认证
  operatorAuth(data):Observable<string[]>{
    return this.getUrlPostReturn(this.operatorAuthUrl, data)
  }
  // 上传实名认证信息
  xjdSaveRealInfo(data):Observable<string[]>{
    return this.getUrlPostReturn(this.xjdSaveRealInfoUrl, data)
  }
  // 登录
  xjdLoginBySmsCode(data):Observable<string[]>{
    return this.getUrlPostReturn(this.xjdLoginBySmsCodeUrl, data)
  }

  private getProductUrlByIdUrl = `${this.baseURL}/wwqbAdmin/app/product/getProductUrlById`
  getProductUrlById(data):Observable<string[]>{
    return this.getUrlPostReturn(this.getProductUrlByIdUrl, data)
  }
  
  // get请求
  // private getUrlReturn(url:string, config:any={}):Observable<string[]>{
  //   return this.http.get(url, config)
  //                   .map(this.extractDate)
  //                   .catch(this.handleError);
  // }
  // post请求
  private getUrlPostReturn(url:string, data:any={}):Observable<string[]>{
    let header = new Headers({
      'app_token': window.localStorage.getItem('phoneNum')
    });
    let options = new RequestOptions({
      headers: header
    });
    // console.log('this.headers', options)
    return this.http.post(url, data, options)
                    .map(this.extractDate)
                    .catch(this.handleError);
  }
 
  //处理接口返回的数据,处理成json格式
  private extractDate(res:Response){
    let body = res.json();
    return body || {};
  }
 
  // //处理请求中的错误，考虑了各种情况的错误处理并在console.log中显示error
  private handleError(error:Response | any){
    console.log('错误处理err',  error)
    if(error.status == 401 || error.status == 500){
      return Promise.reject(error['status']);
    }
    let errMsg:string;
    if(error instanceof Response){
      const err = error || '';
      errMsg = `${error.status} - ${error.statusText || ''} ${err}`;
    }else{
      errMsg = error.message?error.message:error.toString()
    }
    console.log('errorMsg', errMsg);
    return Promise.reject(errMsg);
  }
}
