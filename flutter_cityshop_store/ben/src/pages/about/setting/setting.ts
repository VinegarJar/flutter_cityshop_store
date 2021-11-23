import { Component } from '@angular/core';
import { NavController, NavParams, Events } from 'ionic-angular';
// @IonicPage()
@Component({
  selector: 'page-setting',
  templateUrl: 'setting.html',
})
export class SettingPage {
  errorMessage: any;
  constructor(public navCtrl: NavController,
              public navParams: NavParams,
              public events: Events
    ) {
  }
  exit(){
    window.localStorage.removeItem('phoneNum');
    this.events.publish('toLogin');
    this.events.unsubscribe('toLogin');
  }
}