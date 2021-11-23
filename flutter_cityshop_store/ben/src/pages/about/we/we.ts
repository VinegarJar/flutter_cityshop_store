import { Component } from '@angular/core';
import { NavController, NavParams, Events } from 'ionic-angular';
// @IonicPage()
@Component({
  selector: 'page-we',
  templateUrl: 'we.html',
})
export class WePage {
  errorMessage: any;
  constructor(public navCtrl: NavController,
              public navParams: NavParams,
              public events: Events
    ) {
  }
  exit(){
    window.localStorage.removeItem('phoneNum');
    this.events.publish('toLogin');
  }
}