import { Component, ElementRef, ViewChild } from '@angular/core';
import { NavController, LoadingController, ToastController, Events, AlertController } from 'ionic-angular';
import { BaseUI } from '../../../common/baseui';
import { ApiProvider } from '../../../providers/api/api';
import { ThemeableBrowser, ThemeableBrowserOptions, ThemeableBrowserObject } from '@ionic-native/themeable-browser';
import { FileTransfer, FileTransferObject } from '@ionic-native/file-transfer';
import { File } from '@ionic-native/file';
import { FileOpener } from '@ionic-native/file-opener';
import { AndroidPermissions } from '@ionic-native/android-permissions';
import { Device } from '@ionic-native/device';
import { DclistPage } from '../dclist/dclist'
import { DialogPrdComponent } from '../../../components/dialog-prd/dialog-prd'
// @IonicPage()
@Component({
  selector: 'page-result',
  templateUrl: 'result.html'
})
export class ResultPage extends BaseUI{
  @ViewChild('child1')
  child1: DialogPrdComponent;
  public time:number = 60;
  public dialogS: Boolean = false;
  smsBtn: boolean = true;
  errorMessage: any;
  telephoneNum: string = "";
  smsCode: string = "";
  password: string = "";
  fuwuye: any = true;
  status: any = '0';
  userAppType: any = 0;
  public productArr: any = [];
  private options: ThemeableBrowserOptions = {
    statusbar: {
      color: '#FF3735ff'
    },
    toolbar: {
        height: 44,
        color: '#FF3735ff'
    },
    title: {
        color: '#FFFFFFff',
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
  constructor(private themeableBrowser: ThemeableBrowser,
              public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public api: ApiProvider,
              public events: Events,
              private alertCtrl: AlertController,
              private transfer: FileTransfer,
              private file: File,
              private fileOpener: FileOpener,
              private androidPermissions: AndroidPermissions,
              private device: Device,
              public element: ElementRef,
              ) {
    super();
  }
  //获取贷款大全列表
  getData(){
    let loading = super.showLoading(this.loadingCtrl, "");
    this.productArr = [];
    let params = {
      pageNum: 1,
      pageSize:30,
      isAndroid: Number(window.localStorage.getItem('androidVisited')) || 0,
      isIos: Number(window.localStorage.getItem('iosVisited')) || 0
    }
    this.api.getJqbList(params).subscribe(f => {
      this.productArr = f['list']
      loading.dismiss()
    }, err => {
      this.errorMessage=<any>err;
      loading.dismiss()
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        this.events.publish('toLogin');
      }
    })
  }
  //下拉刷新
  doRefresh(refresher) {
    console.log('Begin async operation', refresher);
    setTimeout(() => {
      this.getData();
      refresher.complete();
    }, 1000);
  }
  ionViewDidLoad(){
    this.getData();
  }
  getApproval(){
    let params = {
      phoneNum: window.localStorage.getItem('phoneNum')
    }
    this.api.getApprovalStatus(params).subscribe(f => {
      console.log('f', f)
    })
  }
  isShowDialog(){
    let params = {
      phoneNum: window.localStorage.getItem('phoneNum')
    }
    // this.dialogS = true // 测试启动
    this.api.isShowDialog(params).subscribe(f => {
      console.log('ffff', f)
      if(f['code'] === 200){
        this.dialogS = true
        if((this.dialogS && this.userAppType === '1') || (this.dialogS && this.userAppType === '2' && this.status === '0')){
          setTimeout(() => {
            this.child1.getDialogProd()
            let a = this.element.nativeElement.querySelector('.scroll-content').scrollHeight
            this.element.nativeElement.querySelector('.dialog-s').style.height = a + 'px';
          }, 0)
        }
      }
    }, err => {
      this.errorMessage=<any>err 
    })
  }
  outpust($event) {
    console.log('outpust', $event)
    this.dialogS = false
  }
  // 进入页面之前
  ionViewDidEnter(){
    this.status = window.localStorage.getItem('approvalStatus');
    this.userAppType = window.localStorage.getItem('userAppType');
    this.isShowDialog()
  }
  //产品点击
  itemSelected(item){
    this.api.getProductUrlById({productId: item.productId }).subscribe(f => {
        // 判断链接是否有协议，没有则加上
      if(f!=null && f['result'].indexOf('https://') === -1 && f['result'].indexOf('http://') === -1){
        item.productShortUrl = 'http://' + f['result']
      }else{
        item.productShortUrl =  f['result']
      }
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPV',
        extraParam1: item.productId,//点击app的id
        extraParam2: '贷款罗盘'
      };
      this.options['title']['staticText'] = item.productName;
      this.api.addEvent(params).subscribe(g => {
        console.log('APP点击埋点触发');
      }, err => {
        if(err == 401 || err == 500){
          window.localStorage.removeItem('phoneNum')
          this.events.publish('toLogin');
        }
      });
      this.browser = this.themeableBrowser.create(item.productShortUrl, '_blank', this.options);
      let t = null;
      let data = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPR',
        extraParam1: item.productId,//点击app的id
        extraParam2: '贷款大全'
      }
      t = setTimeout(() => {
        this.api.addEvent(data).subscribe(h => {
          console.log('预计注册埋点触发');
        })
      }, 15000)
      this.browser.on('loadstart').subscribe(event => {
        if (event['url'].indexOf('.apk') > -1){
          this.userDate(event['url'], this.browser)
        } else if (event['url'].indexOf('fir.im') > -1){
          this.browser = this.themeableBrowser.create(event['url'], '_system', this.options);
        }
      });
      this.browser.on('exit').subscribe(event => {
        clearTimeout(t);
        console.log('预计注册埋点取消');
      });
    }, err => {
      this.errorMessage=<any>err 
    })
  }
  getlastXieGang(str){
    let string = str;
    let pos = string.indexOf("?");
    if (pos > -1) {
      string = string.substring(0, pos);
    }
    pos = string.lastIndexOf("/");
    if (pos > -1) {
      string = string.substring(pos + 1, string.length);
    }
    return string;
  }
  downloadApp(apkUrl){
    const fileTransfer: FileTransferObject = this.transfer.create();
    const apk = this.file.externalDataDirectory + this.getlastXieGang(apkUrl); //apk保存的目录
    fileTransfer.download(apkUrl, apk, true).then((entry) => {
        this.fileOpener.open(decodeURI(entry.toURL()), 'application/vnd.android.package-archive').then(() =>{
            console.log('File is opened')
        }).catch(e => {
            console.log('Error openening file', e)
        });
    });
  }
  userDate(url, browser){
    this.browser = browser;
    this.androidPermissions.checkPermission(this.androidPermissions.PERMISSION.READ_EXTERNAL_STORAGE).then(
      result => {
        console.log('Has permission?', result.hasPermission)
        // this.downloadApp(url, browser)
      },
      err => {
        this.androidPermissions.requestPermission(this.androidPermissions.PERMISSION.READ_EXTERNAL_STORAGE)
      }
    );
    return new Promise((resolve)=>{
      this.androidPermissions.requestPermissions([this.androidPermissions.PERMISSION.READ_EXTERNAL_STORAGE, this.androidPermissions.PERMISSION.GET_ACCOUNTS]).then((res)=>{
        if((this.device.model.toLowerCase().indexOf('oppo') > -1) || (this.device.model.toLowerCase().indexOf('vivo') > -1)){
          this.browser = this.themeableBrowser.create(url, '_system', this.options);
        }else{
          this.downloadApp(url);
          browser.close();
          let alert = this.alertCtrl.create({
            title: '提示',
            subTitle: '正在下载中...',
            buttons: ['确认']
          });
          alert.present();
        }
        resolve(res)
      })
    })
  }
  shenqing() {
    this.navCtrl.setRoot(DclistPage);
  }
}