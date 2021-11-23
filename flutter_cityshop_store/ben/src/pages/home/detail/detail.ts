import { Component } from '@angular/core';
import { NavController, LoadingController, ToastController, Events, AlertController } from 'ionic-angular';
import { BaseUI } from '../../../common/baseui';
// @IonicPage()
@Component({
  selector: 'page-detail',
  templateUrl: 'detail.html'
})
export class DetailPage extends BaseUI{
  constructor(public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public events: Events,
              public alertCtrl: AlertController
              ) {
    super();
  }
}
