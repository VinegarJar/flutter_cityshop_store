import { Component } from '@angular/core';
import { NavController, NavParams, Events, AlertController } from 'ionic-angular';
// import { ApiProvider } from '../../providers/api/api';
import { SettingPage } from './setting/setting';
import { ComplaintPage } from './complaint/complaint';
import { WePage } from './we/we';
// @IonicPage()
@Component({
  selector: 'page-about',
  templateUrl: 'about.html',
})
export class AboutPage {
  miId: string;
  version: any = '';
  mifenScore: number = 0;
  errorMessage: any;
  constructor(public navCtrl: NavController,
              public navParams: NavParams,
              // public api: ApiProvider,
              public events: Events,
              public alertCtrl: AlertController
    ) {
  }

  ionViewDidEnter() {
    this.miId = window.localStorage.getItem('miId');
    // this.api.getUserinfo({phoneNum: window.localStorage.getItem('phoneNum')}).subscribe(f => {
    //   console.log('f', f)
    //   this.mifenScore = f['miScore']
    // }, err => {
    //   this.errorMessage=<any>err;
    //   if(err == 401 || err == 500){
    //     this.signOut();
    //   }
    // })
  }
  signOut(){
    window.localStorage.removeItem('phoneNum');
    this.events.publish('toLogin');
  }
  pushSetting(){
    this.navCtrl.push(SettingPage);
  }
  pushComplaint(){
    this.navCtrl.push(ComplaintPage);
  }
  kefuhaoma(){
    this.navCtrl.push(WePage);
    // let alert = this.alertCtrl.create({
    //   title: '提示',
    //   subTitle: '号码: 13071343532',
    //   buttons: ['确认']
    // });
    // alert.present();
  }
  kefuhaoma2(){
    let alert = this.alertCtrl.create({
      title: '提示',
      subTitle: '联系方式1：18803131036',
      message: '联系方式2：15230369762',
      buttons: ['确认']
    });
    alert.present();
  }
}
