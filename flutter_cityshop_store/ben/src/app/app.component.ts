/// 
import { Component } from '@angular/core';
import { Platform, Events } from 'ionic-angular';
import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';

import { TabsPage } from '../pages/tabs/tabs';
import { LoginPage } from '../pages/login/login';

import { MobileAccessibility } from '@ionic-native/mobile-accessibility';
import { Device } from '@ionic-native/device';

@Component({
  templateUrl: 'app.html'
})
export class MyApp {
  rootPage:any = LoginPage;
  // rootPage:any = TabsPage;
  
  constructor(platform: Platform,
              statusBar: StatusBar,
              splashScreen: SplashScreen,
              public events: Events,
              private mobileAccessibility: MobileAccessibility,
              public device: Device
              ) {
    if (window.localStorage.getItem('phoneNum')) {
      this.rootPage = TabsPage;
    } else {
      this.rootPage = LoginPage;
    }
    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      // statusBar.styleDefault();
    
      statusBar.backgroundColorByHexString("#FC7028");
      splashScreen.hide();
      this.mobileAccessibility.usePreferredTextZoom(false);
      if (this.device.platform) {
        if (this.device.platform.toLowerCase().indexOf('ios') > -1) {
          window.localStorage.setItem('androidVisited', '0');
          window.localStorage.setItem('iosVisited', '1');
        } else {
          window.localStorage.setItem('androidVisited', '1');
          window.localStorage.setItem('iosVisited', '0');
        }
      } else {
        window.localStorage.setItem('androidVisited', '0');
        window.localStorage.setItem('iosVisited', '0');
      }
    });
    // this.events.subscribe('rongyunIM', () => {
    //   this.initRongIM();
    // });
  }
}
