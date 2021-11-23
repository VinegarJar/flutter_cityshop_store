import { Component } from '@angular/core';
import { NavController, LoadingController, ToastController, Events } from 'ionic-angular';
import { BaseUI } from '../../../common/baseui';
import { ApiProvider } from '../../../providers/api/api';
import { AuthPage } from '../../auth/auth'
import { DetailPage } from '../../home/detail/detail'
// @IonicPage()
@Component({
  selector: 'page-basicinfo',
  templateUrl: 'basicinfo.html'
})
export class BasicinfoPage extends BaseUI{
  public readonly: any = false;
  public username: any = '';
  public hunyin: string = '';
  public companyAddress: string = '';
  public companyCity: string = '';
  public companyName: string = '';
  public companyPhone: string = '';
  public education: any = null;
  public email: string = '';
  public firstContactName: string = '';
  public firstContactPhoneNum: string = '';
  public firstContactRelation: string = '';
  public loanReason: string = '';
  public occupation: string = '';
  public otherLoanMoney: string = '';
  public presentAddress: string = '';
  public presentCity: string = '';
  public workIncome: string = '';
  public married: string = '';
  constructor(public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public api: ApiProvider,
              public events: Events
              ) {
    super();
  }
  ionViewDidLoad(){
  }
  // 进入页面之前
  ionViewDidEnter(){
    // this.api.getBasicInfo({}).subscribe(f => {
    //   console.log('bankinfo', f);
    //   let res = f['result'];
    //   this.companyAddress = res.companyAddress;
    //   this.companyCity = res.companyCity;
    //   this.companyName = res.companyName;
    //   this.companyPhone = res.companyPhone;
    //   this.education = res.education;
    //   this.email = res.email;
    //   this.firstContactName = res.firstContactName;
    //   this.firstContactPhoneNum = res.firstContactPhoneNum;
    //   this.firstContactRelation = res.firstContactRelation;
    //   this.loanReason = res.loanReason;
    //   this.occupation = res.occupation;
    //   this.otherLoanMoney = res.otherLoanMoney;
    //   this.presentAddress = res.presentAddress;
    //   this.presentCity = res.presentCity;
    //   this.workIncome = res.workIncome;
    // })
    // this.api.getAuthInfo({}).subscribe(f => {
    //   if(f['basicInfoVerify']){
    //     this.readonly = true;
    //   }else{
    //     this.readonly = false;
    //   }
    // },err => {
    // })
  }
  submitClick(){
    if(!this.username.length ||
      !this.occupation.length || !this.presentAddress.length ||
      !this.education === null){
        super.showToast(this.toastCtrl, '请填写必填项');
        return
    }
    this.navCtrl.push(AuthPage)
    // let params = {
    //   "companyAddress": this.companyAddress,
    //   "companyCity": this.companyCity,
    //   "companyName": this.companyName,
    //   "companyPhone": this.companyPhone,
    //   "education": Number(this.education),
    //   "email": this.email,
    //   "firstContactName": this.firstContactName,
    //   "firstContactPhoneNum": this.firstContactPhoneNum,
    //   "firstContactRelation": this.firstContactRelation,
    //   "loanReason": this.loanReason,
    //   "occupation": this.occupation,
    //   "otherLoanMoney": this.otherLoanMoney,
    //   "presentAddress": this.presentAddress,
    //   "presentCity": this.presentCity,
    //   "workIncome": this.workIncome
    // }
    // this.api.basicInfo(params).subscribe(f => {
    //   this.navCtrl.pop()
    // }, err => {
    //   super.showToast(this.toastCtrl, '提交失败，请重试');
    //   if(err == 401 || err == 500){
    //     window.localStorage.removeItem('phoneNum')
    //     // this.events.publish('toLogin');
    //   }
    // })
  }
  pushXieyi() {
    this.navCtrl.push(DetailPage)
  }
}