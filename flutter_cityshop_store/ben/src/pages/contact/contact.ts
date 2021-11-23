import { Component } from '@angular/core';
import { NavController, LoadingController, ToastController, Events, AlertController } from 'ionic-angular';
import { BaseUI } from '../../common/baseui';
import { AuthlistPage } from '../authlist/authlist'
// import { MessageboxPage } from './messagebox/messagebox';
// import { ContactusPage } from './contactus/contactus';
import { ApiProvider } from '../../providers/api/api';
// @IonicPage()
@Component({
  selector: 'page-contact',
  templateUrl: 'contact.html'
})
export class ContactPage extends BaseUI{
  public loanAmount: any = '- -';
  public loanAmountPay: any = '- -';
  constructor(public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public events: Events,
              public api: ApiProvider,
              private alertCtrl: AlertController
              ) {
    super();
  }
  ionViewDidLoad(){
  }
  // 进入页面之前
  // ionViewDidEnter(){
  //   this.api.getAuthInfo({}).subscribe(f => {
  //     if(f['realNameVerify'] && f['yysVerify'] && f['basicInfoVerify'] && f['bankVerify']){
  //       this.loanAmount = 0
  //       this.loanAmountPay = 0
  //     }else{
  //       this.loanAmount = '- -'
  //       this.loanAmountPay = '- -'
  //     }    
  //   }, err => {
  //     if(err == 401 || err == 500){
  //       window.localStorage.removeItem('phoneNum')
  //       // this.events.publish('toLogin');
  //     }
  //   })
  // }
  pushMessagePage(){
    let alert = this.alertCtrl.create({
      title: '提示',
      subTitle: '您还没有账单哦，先去借一笔',
      buttons: ['确认']
    });
    alert.present();
    // this.navCtrl.push(MessageboxPage)
  }
  pushUsPage(){
    let alert = this.alertCtrl.create({
      title: '提示',
      subTitle: '您还没有账单哦，先去借一笔',
      buttons: ['确认']
    });
    alert.present();
   
  }
  contactSer(){
  
  }
  exit(){
    window.localStorage.removeItem('phoneNum')
    // this.events.publish('toLogin');
  }
  authClick(){
    this.navCtrl.push(AuthlistPage)
  }
  tixian(){
    this.navCtrl.parent.select(1);
  }
}
