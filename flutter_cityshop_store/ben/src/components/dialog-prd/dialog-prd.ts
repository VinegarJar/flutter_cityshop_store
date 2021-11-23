import { Component, Output, Input, EventEmitter } from '@angular/core';
import { Events, AlertController } from 'ionic-angular';
import { ApiProvider } from '../../providers/api/api';
import { ThemeableBrowser, ThemeableBrowserOptions, ThemeableBrowserObject } from '@ionic-native/themeable-browser';
import { FileTransfer, FileTransferObject } from '@ionic-native/file-transfer';
import { File } from '@ionic-native/file';
import { FileOpener } from '@ionic-native/file-opener';
import { AndroidPermissions } from '@ionic-native/android-permissions';
import { Device } from '@ionic-native/device';

/**
 * Generated class for the DialogPrdComponent component.
 *
 * See https://angular.io/api/core/Component for more info on Angular
 * Components.
 */
@Component({
  selector: 'dialog-prd',
  templateUrl: 'dialog-prd.html'
})
export class DialogPrdComponent {
  @Input()values:any;
  @Output() out:EventEmitter<any> = new EventEmitter;
  public productImgUrl: String = '';
  public productName: String = '';
  public loanUpper: String = '';
  public productId: any;
  public shortContent: String = '';
  public errorMessage:any;
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
  public productShortUrl: any = '';
  constructor(
    public api: ApiProvider,
    private themeableBrowser: ThemeableBrowser,
    public events: Events,
    private transfer: FileTransfer,
    private file: File,
    private fileOpener: FileOpener,
    private androidPermissions: AndroidPermissions,
    private device: Device,
    private alertCtrl: AlertController
    ) {
  }

  productSelected(){
    if(!this.productId){
      return
    }
    this.api.getProductUrlById({productId: this.productId }).subscribe(f => {
      // 判断链接是否有协议，没有则加上
      if(f!=null && f['result'].indexOf('https://') === -1 && f['result'].indexOf('http://') === -1){
        this.productShortUrl = 'http://' + f['result']
      }else{
        this.productShortUrl = f['result']
      }
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPV',
        extraParam1: this.productId,//点击app的id
        extraParam2: '首页弹窗'
      };
      // this.options['title']['staticText'] = this.productName;
      this.api.addEvent(params).subscribe(g => {
        console.log('APP点击埋点触发');
      }, err => {
        if(err == 401 || err == 500){
          window.localStorage.removeItem('phoneNum')
          this.events.publish('toLogin');
        }
      });
      this.browser = this.themeableBrowser.create(this.productShortUrl, '_blank', this.options);
      let t;
      let data = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPR',
        extraParam1: this.productId,//点击app的id
        extraParam2: '首页弹窗'
      }
      t = setTimeout(() => {
        this.api.addEvent(data).subscribe(h => {
          console.log('预计注册埋点触发');
        })
      }, 15000)
      this.browser.on('loadstart').subscribe(event => {
        if(event['url'].indexOf('.apk') > -1){
          this.userDate(event['url'], this.browser);
        }else if (event['url'].indexOf('fir.im') > -1){
          this.browser = this.themeableBrowser.create(event['url'], '_system', this.options);
        }
      });
      this.browser.on('exit').subscribe(event => {
        clearTimeout(t);
        // console.log('预计注册埋点取消');
      });
    }, err => {
      this.errorMessage=<any>err 
    })
  }

  userDate(url, browser){
    this.browser = browser;
    this.androidPermissions.checkPermission(this.androidPermissions.PERMISSION.READ_EXTERNAL_STORAGE).then(
      result => {
        console.log('Has permission?', result.hasPermission)
        // this.downloadApp(url)
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

  downloadApp(apkUrl){
    const fileTransfer: FileTransferObject = this.transfer.create();
    const apk = this.file.externalDataDirectory + this.getlastXieGang(apkUrl); //apk保存的目录
    fileTransfer.download(apkUrl, apk, true).then((entry) => {
        this.fileOpener.open(decodeURI(entry.toURL()), 'application/vnd.android.package-archive').then(() =>{
          console.log('File is opened')
        }).catch(e => {
          console.log('File is fail')
        });
    }, err => {
      console.log('download is fail')
    });
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

  getDialogProd(){
    this.api.getDialogProd({}).subscribe(f => {
      if(f!=null && f['result']){
        this.productId = f['result']['productId']
        this.productImgUrl = f['result']['productImgUrl'] || ''
        this.productName = f['result']['productName'] || ''
        this.loanUpper = f['result']['loanUpper']
        this.shortContent = f['result']['shortContent']
        this.options['title']['staticText'] = f['result']['productName'] || ''
      }
    }, err => {
      this.errorMessage=<any>err 
    })
  }

  closeS() {
    console.log('11111')
    this.out.emit(false)
  }
}
