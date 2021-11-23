import { Component } from '@angular/core';
import { NavController, LoadingController, ToastController, Events } from 'ionic-angular';
import { BaseUI } from '../../common/baseui';
import { AuthPage } from '../auth/auth';
import { BasicinfoPage } from './basicinfo/basicinfo';
import { BankinfoPage } from './bankinfo/bankinfo';
import { OperatorPage } from './operator/operator';
import { ApiProvider } from '../../providers/api/api';
// @IonicPage()
@Component({
  selector: 'page-authlist',
  templateUrl: 'authlist.html'
})
export class AuthlistPage extends BaseUI{
  public realNameVerify:string = '未认证';
  public yysVerify:string = '未认证';
  public basicInfoVerify:string = '未认证';
  public bankVerify:string = '未认证';
  constructor(public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public api: ApiProvider,
              public events: Events
              ) {
    super();
  }
  pushAuthPage(){
    if(this.realNameVerify === '未认证'){
      this.navCtrl.push(AuthPage)
    }
  }
  pushBasicinfoPage(){
    if(this.yysVerify === '未认证'){
      super.showToast(this.toastCtrl, '请先完成上一个认证')
      return
    }
    // if(this.basicInfoVerify === '未认证'){
    this.navCtrl.push(BasicinfoPage)
    // }
  }
  pushBankinfoPage(){
    if(this.basicInfoVerify === '未认证'){
      super.showToast(this.toastCtrl, '请先完成上一个认证')
      return
    }
    // if(this.bankVerify === '未认证'){
    this.navCtrl.push(BankinfoPage)
    // }
  }
  pushOperatorPage(){
    if(this.realNameVerify === '未认证'){
      super.showToast(this.toastCtrl, '请先完成上一个认证')
      return
    }
    if(this.yysVerify === '未认证'){
      this.navCtrl.push(OperatorPage)
    }
  }
  ionViewDidLoad(){
  }
  // 进入页面之前
  ionViewDidEnter(){
    this.api.getAuthInfo({}).subscribe(f => {
      console.log('ffff', f)
      this.realNameVerify = f['realNameVerify'] ? '已认证' : '未认证'
      this.yysVerify = f['yysVerify'] ? '已认证' : '未认证'
      this.basicInfoVerify = f['basicInfoVerify'] ? '已认证' : '未认证'
      this.bankVerify = f['bankVerify'] ? '已认证' : '未认证'
    },err => {
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        // this.events.publish('toLogin');
      }
    })
  }
}