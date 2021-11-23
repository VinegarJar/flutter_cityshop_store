import { Component } from '@angular/core';
import { AboutPage } from '../about/about';
import { ContactPage } from '../contact/contact';
import { HomePage } from '../home/home';
import { LoginPage } from '../login/login'
import { Events, NavController } from 'ionic-angular';

// import { PersonPage } from '../person/person';
// @IonicPage()
@Component({
  selector: 'page-tabs',
  templateUrl: 'tabs.html'
})
export class TabsPage {
  tab1Root = HomePage;
  tab2Root = AboutPage;
  tab3Root = ContactPage;

  // tab4Root = PersonPage;
  constructor(public events: Events, public navCtrl: NavController) {
  }
  ionViewDidLoad() {
    this.listenEvents();
    console.log('界面创建');
  }
  ngOnDestroy() {
    // this.events.unsubscribe('toLogin');
    console.log('界面销毁');
  }
  listenEvents() {
    this.events.subscribe('toLogin', () => {
      this.navCtrl.setRoot(LoginPage);
      window.location.reload()
      // window.localStorage.removeItem('rongToken');
      // console.log('返回登录');
    });
  }
}
