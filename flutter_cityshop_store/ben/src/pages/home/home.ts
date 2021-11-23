import { Component, ElementRef } from '@angular/core';
import { NavController, ToastController, Events } from 'ionic-angular';
import { ApiProvider } from '../../providers/api/api';
import { BaseUI } from '../../common/baseui';
import { BasicinfoPage } from '../authlist/basicinfo/basicinfo'
import { ResultPage } from '../authlist/result/result'
import { DclistPage } from '../authlist/dclist/dclist'
import { DetailPage } from './detail/detail'
import { ThemeableBrowser, ThemeableBrowserOptions, ThemeableBrowserObject } from '@ionic-native/themeable-browser';
declare let $:any;
// @IonicPage()
@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage extends BaseUI{
  lixi: any;
  qishu: number = 24;
  meiqi: any;
  buttonText: string = '申请额度';
  saturation: string = '10000';
  private fengkongUrl: string = 'http://h5.wzryj88.com/login.html?c=07ae65fbcc8844ad8b06ef892665059a&t=main';
  errorMessage:any;
  t:any = null;
  private options: ThemeableBrowserOptions = {
    statusbar: {
      color: '#f53d3dff'
    },
    toolbar: {
        height: 44,
        color: '#f53d3dff'
    },
    title: {
        color: '#FFFFFFFF',
        showPageTitle: true
    },
    closeButton: {
      wwwImage: 'assets/imgs/back.png',
      align: 'left',
      event: 'closePressed',
      wwwImageDensity: 1.7
    },
    backButtonCanClose: true
  };
  browser:ThemeableBrowserObject;
  constructor(public navCtrl: NavController,
              public api: ApiProvider,
              public toastCtrl: ToastController,
              public element: ElementRef,
              private themeableBrowser: ThemeableBrowser,
              public events: Events
              ) {
    super();
    this.setBackground();
  }
  chengeM(){
    this.lixi = (Number(this.saturation)*0.0002*30).toFixed(2);
    this.meiqi = ((Number(this.saturation)*0.0002*30*this.qishu+Number(this.saturation))/this.qishu).toFixed(2);
  }
  setBackground(){
  }
  authClick2(){
    const realNameVerify = window.localStorage.getItem('realNameVerify')
    const preSwitch = window.localStorage.getItem('preSwitch')
    if(preSwitch === '1'){
      if(realNameVerify === '1'){ // 已认证
        this.navCtrl.push(ResultPage)
      }else{ // 未认证
        this.navCtrl.push(BasicinfoPage)
      }
    }else{
      this.navCtrl.setRoot(DclistPage)
    }
    // let params = {
    //   loanMoney: this.saturation,
    //   loanDate: this.qishu,
    //   eachMoney: this.meiqi
    // }
    // this.api.insertRecord(params).subscribe(f => {
    //   console.log('添加订单', f)
    //   // this.navCtrl.push(AuthlistPage)
    // },err => {
    //   super.showToast(this.toastCtrl, '申请失败，请重试');
    //   if(err == 401 || err == 500){
    //     window.localStorage.removeItem('phoneNum')
    //     this.events.publish('toLogin');
    //   }
    // })
   
  }
  authClick(){
    let a = document.getElementsByName('check');
    if(!a[0]['checked']){
      super.showToast(this.toastCtrl, '请先同意相关协议')
      return
    }
    clearTimeout(this.t);
    this.t = setTimeout(() => {
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum')
      }
      this.api.insertRecord(params).subscribe(f => {
        // 插入成功
      },err => {
        this.errorMessage=<any>err;
      })
    }, 20000)
    this.options['title']['staticText'] = '';
    if(this.fengkongUrl && this.fengkongUrl.length){
      // 判断链接是否有协议，没有则加上
      if(this.fengkongUrl.indexOf('https://') === -1 && this.fengkongUrl.indexOf('http://') === -1){
        this.fengkongUrl = 'http://' + this.fengkongUrl
      }
      this.browser = this.themeableBrowser.create(this.fengkongUrl, '_system',this.options);
      this.browser.on('loadstart').subscribe(event => {
        console.log('内置浏览器运行中..')
      });
      this.browser.on('exit').subscribe(event => {
        clearTimeout(this.t);
        console.log('退出内置浏览器')
      });
    }
  }
  pushXieyi(){
    this.navCtrl.push(DetailPage)
  }
  //每日签到
  // signin(){
  //   this.navCtrl.push(PersonPage);
  // }
  // 钩子函数，只加载一次
  ionViewDidLoad(){
    const realNameVerify = window.localStorage.getItem('realNameVerify')
    const userAppType = window.localStorage.getItem('userAppType')
    const preSwitch = window.localStorage.getItem('preSwitch')
    if(preSwitch === '1'){
      if (userAppType === '1' && realNameVerify === '1') {
        this.navCtrl.setRoot(DclistPage)
      }
    }else{
      if(userAppType === '1'){
        this.navCtrl.setRoot(DclistPage)
      }
    }
  }
  // 钩子函数 -- 进入页面之后
  ionViewDidEnter(){
    this.lixi = (Number(this.saturation)*0.0002*30).toFixed(2);
    this.meiqi = ((Number(this.saturation)*0.0002*30*this.qishu+Number(this.saturation))/this.qishu).toFixed(2);
    // let params = {
    //   phoneNum: window.localStorage.getItem('phoneNum') || ''
    // }
    // if(!params.phoneNum){
    //   this.saturation = '请先认证';
    //   this.buttonText = '申请额度';
    //   return
    // }
    // this.api.getUserinfo(params).subscribe(f => {
    //   this.saturation = f['loanAmount'] || '请先申请';
    //   this.fengkongUrl = f['fengkongUrl'] || '';
    //   if(this.saturation == '0'){
    //     this.buttonText = '申请额度';
    //   }else{
    //     this.buttonText = '申请借款';
    //   }
    // },err => {
    //   this.errorMessage=<any>err;
    //   this.events.publish('toLogin');
    // })
    let params = {
      phoneNum: window.localStorage.getItem('phoneNum')
    }
    this.api.getApprovalStatus(params).subscribe(f => {
      window.localStorage.setItem('approvalStatus', f['result']['status'])
    })
 
  }
  chengePeriod(){
    let _thise = this;
    $(".period-item").click(function(){
      $(this).addClass("blue").siblings().removeClass("blue");
      console.log('$(this)', $(this).index())
      if($(this).index() == 0){
        _thise.qishu = 3;
      }else if($(this).index() == 1){
        _thise.qishu = 6;
      }else if($(this).index() == 2){
        _thise.qishu = 12;
      }else if($(this).index() == 3){
        _thise.qishu = 24;
      }else{
        _thise.qishu = 24;
      }
      _thise.meiqi = ((Number(_thise.saturation)*0.0002*30*_thise.qishu+Number(_thise.saturation))/_thise.qishu).toFixed(2);
    });
  }
  // 钩子函数 -- 离开页面之后
  // ionViewDidLeave(){
  // }
}
