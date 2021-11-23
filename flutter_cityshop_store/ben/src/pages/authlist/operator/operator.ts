import { Component } from '@angular/core';
import { NavController, LoadingController, ToastController, Events } from 'ionic-angular';
import { BaseUI } from '../../../common/baseui';
import { ApiProvider } from '../../../providers/api/api';
// @IonicPage()
@Component({
  selector: 'page-operator',
  templateUrl: 'operator.html'
})
export class OperatorPage extends BaseUI{
  public time:number = 60;
  smsBtn: boolean = true;
  errorMessage: any;
  telephoneNum: string = "";
  smsCode: string = "";
  password: string = "";
  fuwuye: any = true;
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
  }
  // 提交
  submitClick(){
    if(!this.telephoneNum.length){
      super.showToast(this.toastCtrl, '请输入手机号码');
      return
    }
    if(!this.smsCode.length){
      super.showToast(this.toastCtrl, '请输入验证码');
      return
    }
    this.api.operatorAuth({}).subscribe(f => {
      this.navCtrl.pop()
    }, err => {
      super.showToast(this.toastCtrl, '提交失败，请重试');
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        // this.events.publish('toLogin');
      }
    })
  }
  getSmsCode(){
    if(!this.telephoneNum.length){
      super.showToast(this.toastCtrl, '请输入手机号码');
      return
    }
    if(!this.password.length){
      super.showToast(this.toastCtrl, '请输入服务密码');
      return
    }
    let sendData = {
      phoneNum: this.telephoneNum,
      userAppType: 2
    }
    let loading = super.showLoading(this.loadingCtrl, "")
    this.api.xjdSendSmsCode(sendData).subscribe(f => {
      console.log('f', f)
      if(f['code'] == 2020){
        super.showToast(this.toastCtrl, f['msg']);
        loading.dismiss()
        return
      }
      if(f['code'] == 500){
        super.showToast(this.toastCtrl, f['msg']);
        loading.dismiss()
        return
      }
      if(f['code'] == 200){
        this.fuwuye = false;
        this.smsBtn = false
        let t = setInterval(() => {
          this.time = this.time - 1;
          if(this.time == 0){
            this.time = 60;
            clearInterval(t)
            this.smsBtn = true;
          }
        }, 1000);
        // this.smsCode = f['result'];
      }else{
        super.showToast(this.toastCtrl, '请求失败');
      }
      loading.dismiss()
    }, err => {
      this.errorMessage=<any>err;
      super.showToast(this.toastCtrl, '请求失败');
      loading.dismiss()
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        // this.events.publish('toLogin');
      }
    })
  }
}