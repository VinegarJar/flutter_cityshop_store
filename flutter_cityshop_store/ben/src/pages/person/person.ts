import { Component } from '@angular/core';
import { NavController, NavParams } from 'ionic-angular';
import { ApiProvider } from '../../providers/api/api';
import { LoginPage } from '../login/login';
// import { Storage } from "@ionic/storage";
/**
 * Generated class for the PersonPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

// @IonicPage()
@Component({
  selector: 'page-person',
  templateUrl: 'person.html',
})
export class PersonPage {
  username: string;
  errorMessage: any;
  constructor(public navCtrl: NavController,
              public navParams: NavParams,
              public api: ApiProvider
              // public storage: Storage
    ) {
  }

  ionViewDidEnter() {
    if(!window.localStorage.getItem('phoneNum')){
      this.signOut();
    }else{
      this.username = window.localStorage.getItem('phoneNum');
    }
  }
  signOut(){
    window.localStorage.removeItem('phoneNum');
    // this.navCtrl.setRoot(LoginPage);
    this.navCtrl.push(LoginPage).then(() => {
      const startIndex = this.navCtrl.getActive().index - 1;
      this.navCtrl.remove(startIndex, 1);
    });
  }

}
