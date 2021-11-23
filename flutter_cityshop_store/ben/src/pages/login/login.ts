import { Component } from '@angular/core';
import { NavController, NavParams, ViewController, LoadingController, ToastController } from 'ionic-angular';
import { ApiProvider } from '../../providers/api/api';
import { BaseUI } from '../../common/baseui';
// import { Storage } from "@ionic/storage";
// import { GlobalData } from '../../providers/globalData';
import { TabsPage } from '../tabs/tabs';
import { DetailPage } from '../home/detail/detail'
// import { AuthPage } from '../auth/auth';
/**
 * Generated class for the LoginPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

// @IonicPage()
@Component({
  selector: 'page-login',
  templateUrl: 'login.html',
})
export class LoginPage extends BaseUI {
  errorMessage: any;
  telephone: string = "";
  smsCode: string = "";
  smsBtn: boolean = true;
  time: number = 59;
  constructor(public navCtrl: NavController,
              public navParams: NavParams,
              public viewCtrl: ViewController,
              public api: ApiProvider,
              // public storage: Storage,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController
              ) {
                super();
  }
  getSmsCode(){
    if(!this.telephone.length){
      super.showToast(this.toastCtrl, '请输入手机号码');
      return
    }
    let sendData = {
      phoneNum: this.telephone
    }
    let loading = super.showLoading(this.loadingCtrl, "")
    this.api.xjdSendSmsCode(sendData).subscribe(f => {
      console.log('f', f)
      if(f['code'] == 500){
        super.showToast(this.toastCtrl, f['msg']);
        loading.dismiss()
        return
      }
      if(f['code'] == 200){
        this.smsBtn = false
        let t = setInterval(() => {
          this.time = this.time - 1;
          if(this.time == 0){
            this.time = 59;
            clearInterval(t)
            this.smsBtn = true;
          }
        }, 1000);
        // this.smsCode = f['result'];
      }else{
        super.showToast(this.toastCtrl, f['msg']);
      }
      loading.dismiss()
    }, err => {
      this.errorMessage=<any>err;
      super.showToast(this.toastCtrl, '获取失败');
      loading.dismiss()
    })
  }
  ionViewDidLoad() {
    // console.log('ionViewDidLoad LoginPage');
  }
  dismiss(){
    this.viewCtrl.dismiss()
  }
  login(){
    if(!this.telephone.length){
      super.showToast(this.toastCtrl, '请输入手机号码');
      return
    }
    // if(!this.smsCode.length){
    //   super.showToast(this.toastCtrl, '请输入验证码');
    //   return
    // }
    let loginData = {
      phoneNum: this.telephone,
      smsCode: this.smsCode,
      androidVisited: Number(window.localStorage.getItem('androidVisited')) || 0,
      iosVisited: Number(window.localStorage.getItem('iosVisited')) || 0
    }
    let loading = super.showLoading(this.loadingCtrl, "登录中...")

    this.api.xjdLoginBySmsCode(loginData).subscribe(f => {

        console.log('f', f)
        if(f['code'] == 500){
          super.showToast(this.toastCtrl, f['msg']);
          loading.dismiss();
          return
        }
        if(f['code'] == 200){
          // let params = {
          //   'event': 'APP_SLG',
          //   'phoneNum': this.telephone
          // }
          // this.api.addEvent(params).subscribe(g => {
          //   console.log('app登录埋点触发', g);
          // })
          window.localStorage.setItem('phoneNum', this.telephone);
          window.localStorage.setItem('preSwitch', f['result']['preSwitch']);
          window.localStorage.setItem('realNameNeed', f['result']['realNameNeed']);
          window.localStorage.setItem('realNameVerify', f['result']['realNameVerify']);// 0未认证，1已认证
          window.localStorage.setItem('miId', f['result']['miId']);
          // window.localStorage.setItem('approvalStatus', f['result']['status']);// 0待审核，1审核失败，2审核成功
          window.localStorage.setItem('userAppType', f['result']['userAppType']);// 1dc 2 xjd
          super.showToast(this.toastCtrl, '登录成功');
          loading.dismiss();
          // 判断是否需要跳认证页面
          // if(f['result']['realNameNeed'] === 1 && f['result']['realNameVerify'] === 0){
          //   this.navCtrl.push(AuthPage);
          //   this.navCtrl.setRoot(AuthPage)
          // }else{
          this.navCtrl.push(TabsPage);
          this.navCtrl.setRoot(TabsPage)
          // }
        }else{
          super.showToast(this.toastCtrl, f['msg']);
          loading.dismiss();
        }
      },err => {
        this.errorMessage=<any>err;
        super.showToast(this.toastCtrl, '登录失败');
        loading.dismiss();
      })
  }
  pushXieyi(){
    this.navCtrl.push(DetailPage)
  }
}
