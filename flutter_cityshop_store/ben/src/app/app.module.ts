import { NgModule, ErrorHandler } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { MyApp } from './app.component';
import { GlobalData } from '../providers/globalData'

import { ResultPage } from '../pages/authlist/result/result';
import { DclistPage } from '../pages/authlist/dclist/dclist';
import { AboutPage } from '../pages/about/about';
import { ContactPage } from '../pages/contact/contact';
import { HomePage } from '../pages/home/home';
import { TabsPage } from '../pages/tabs/tabs';
import { LoginPage } from '../pages/login/login'
import { PersonPage } from  '../pages/person/person'
import { AuthPage } from  '../pages/auth/auth'
import { AuthlistPage } from  '../pages/authlist/authlist'
import { BasicinfoPage } from '../pages/authlist/basicinfo/basicinfo'
import { BasicinfoPage2 } from '../pages/authlist/basicinfo2/basicinfo2'
import { BankinfoPage } from '../pages/authlist/bankinfo/bankinfo'
import { OperatorPage } from '../pages/authlist/operator/operator'
import { MessageboxPage } from "../pages/contact/messagebox/messagebox";
import { ContactusPage } from "../pages/contact/contactus/contactus";
import { DetailPage } from "../pages/home/detail/detail";
import { SettingPage } from '../pages/about/setting/setting';
import { ComplaintPage } from '../pages/about/complaint/complaint';
import { WePage } from '../pages/about/we/we';

import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';

import { MobileAccessibility } from '@ionic-native/mobile-accessibility';
import { ThemeableBrowser } from '@ionic-native/themeable-browser';
import { HttpModule } from '@angular/http';
import { ApiProvider } from '../providers/api/api';
import { Camera } from "@ionic-native/camera";
import { FileTransfer, FileTransferObject } from '@ionic-native/file-transfer';
import { File } from '@ionic-native/file';
import { FileOpener } from '@ionic-native/file-opener';
import { AndroidPermissions } from '@ionic-native/android-permissions';
import { Device } from '@ionic-native/device';
import { DialogPrdComponent } from '../components/dialog-prd/dialog-prd'
// import { IonicStorageModule } from '@ionic/storage';


@NgModule({
  declarations: [
    MyApp,
    AboutPage,
    ContactPage,
    HomePage,
    TabsPage,
    LoginPage,
    PersonPage,
    AuthPage,
    AuthlistPage,
    BasicinfoPage,
    BasicinfoPage2,
    BankinfoPage,
    OperatorPage,
    MessageboxPage,
    ContactusPage,
    DetailPage,
    SettingPage,
    ComplaintPage,
    ResultPage,
    DclistPage,
    WePage,
    DialogPrdComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    IonicModule.forRoot(MyApp,  {  
      backButtonText: '',// 配置返回按钮的文字 
      tabsHideOnSubPages: 'true'//隐藏全部子页面tabs 
      // backButtonIcon: 'arrow-dropleft-circle' // 配置返回按钮的图标  
    })
    // IonicStorageModule.forRoot()
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    AboutPage,
    ContactPage,
    HomePage,
    TabsPage,
    LoginPage,
    PersonPage,
    AuthPage,
    AuthlistPage,
    BasicinfoPage,
    BasicinfoPage2,
    BankinfoPage,
    OperatorPage,
    MessageboxPage,
    ContactusPage,
    DetailPage,
    SettingPage,
    ComplaintPage,
    ResultPage,
    DclistPage,
    WePage,
    DialogPrdComponent
  ],
  providers: [
    StatusBar,
    SplashScreen,
    {provide: ErrorHandler, useClass: IonicErrorHandler},
    MobileAccessibility,
    ThemeableBrowser,
    Camera,
    ApiProvider,
    GlobalData,
    FileTransfer,
    FileTransferObject,
    File,
    FileOpener,
    AndroidPermissions,
    Device
  ]
})
export class AppModule {}
