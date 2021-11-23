import { Component } from '@angular/core';
import { NavController, LoadingController, ToastController, Events, AlertController } from 'ionic-angular';
import { BaseUI } from '../../../common/baseui';
import { ApiProvider } from '../../../providers/api/api';
// @IonicPage()
@Component({
  selector: 'page-contactus',
  templateUrl: 'contactus.html'
})
export class ContactusPage extends BaseUI{
  public src: string = '';
  constructor(public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public events: Events,
              public alertCtrl: AlertController,
              public api: ApiProvider
              ) {
    super();
  }
  ionViewDidLoad(){
  }
  // 进入页面之前
  ionViewDidEnter(){
    this.api.getPayLink({}).subscribe(f => {
      f && f.length && f.forEach(item => {
        if(item['payType'] = '支付宝'){
          this.src = item['imgUrl'] || '';
        }
      })
    }, err => {
    })
  }
  showAlert() {
    const alert = this.alertCtrl.create({
      
    });
    alert.present();
  }
}
