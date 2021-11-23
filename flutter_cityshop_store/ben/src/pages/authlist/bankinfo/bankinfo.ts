import { Component } from '@angular/core';
import { NavController, LoadingController, ToastController, Events } from 'ionic-angular';
import { BaseUI } from '../../../common/baseui';
import { ApiProvider } from '../../../providers/api/api';
// @IonicPage()
@Component({
  selector: 'page-bankinfo',
  templateUrl: 'bankinfo.html'
})
export class BankinfoPage extends BaseUI{
  public readonly:any = false;
  public bankName:string = "";
  public bankNum:string = "";
  public bankPhoneNum:string = "";
  constructor(public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public api: ApiProvider,
              public events: Events
              ) {
    super();
  }
  // 提交
  submitClick(){
    let params = {
      bankName: this.bankName,
      bankNum: this.bankNum,
      bankPhoneNum: this.bankPhoneNum
    }
    this.api.bankAuth(params).subscribe(f => {
      console.log('绑定银行卡', f)
      this.navCtrl.pop()
    },err => {
      super.showToast(this.toastCtrl, '提交失败，请重试');
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        // this.events.publish('toLogin');
      }
    })
  }
  ionViewDidLoad(){
  }
  // 进入页面之前
  ionViewDidEnter(){
    this.api.getBasicInfo({}).subscribe(f => {
      console.log('bankinfo', f);
      let res = f['result'];
      this.bankName = res.bankName;
      this.bankNum = res.bankNum;
      this.bankPhoneNum = res.bankPhoneNum;
    })
    this.api.getAuthInfo({}).subscribe(f => {
      if(f['bankVerify']){
        this.readonly = true;
      }else{
        this.readonly = false;
      }
    },err => {
    })
  }
}