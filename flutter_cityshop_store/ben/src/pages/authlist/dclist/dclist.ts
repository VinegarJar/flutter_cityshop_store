import { Component, ElementRef, ViewChild } from '@angular/core';
import { NavController, ToastController, Events, Slides, AlertController } from 'ionic-angular';
import { ApiProvider } from '../../../providers/api/api';
import { BaseUI } from '../../../common/baseui';
import { ThemeableBrowser, ThemeableBrowserOptions, ThemeableBrowserObject } from '@ionic-native/themeable-browser';
import { FileTransfer, FileTransferObject } from '@ionic-native/file-transfer';
import { File } from '@ionic-native/file';
import { FileOpener } from '@ionic-native/file-opener';
import { AndroidPermissions } from '@ionic-native/android-permissions';
import { Device } from '@ionic-native/device';
import { DialogPrdComponent } from '../../../components/dialog-prd/dialog-prd'
// declare var $:any;
// @IonicPage()
@Component({
  selector: 'page-dclist',
  templateUrl: 'dclist.html'
})
export class DclistPage extends BaseUI{
  @ViewChild(Slides) slides: Slides;
  @ViewChild('child1')
  child1: DialogPrdComponent;
  paomaSliders: any = [];
  slideArr: any = [];
  public dialogS: Boolean = false;
  public todayRec: any = {
    productName: "",
    longContent: "",
    loanUpper: 0,
    applyNum: 0,
    productShortUrl: "",
    productUrl: "",
    productId: ""
  };
  public line_1: any = 1;
  public line_2: any = 0;
  bottomText: any = '查看全部产品';
  layer: any = false;
  saturation: any = 1000;
  errorMessage:any;
  public layerProductUrl: any = "";
  public layerProductId: any;
  public layerProductName:any;
  // 首页 为您推荐
  public productArr:any = [];
  // 首页 快捷口子
  public productSoonUrl1: any = "";
  public productSoonUrl2: any = "";
  public productSoonUrl3: any = "";
  public productSoonUrl4: any = "";
  public productSoonUrl5: any = "";
  public productSoonUrl6: any = "";
  public productSoonUrl7: any = "";
  public productSoonUrl8: any = "";
  public todayRecommendShow: any = 1;
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
  constructor(public navCtrl: NavController,
              public api: ApiProvider,
              public toastCtrl: ToastController,
              private themeableBrowser: ThemeableBrowser,
              public element: ElementRef,
              public events: Events,
              private alertCtrl: AlertController,
              private transfer: FileTransfer,
              private file: File,
              private fileOpener: FileOpener,
              private androidPermissions: AndroidPermissions,
              private device: Device
              ) {
    super();
  }
  // 
  getPaoma(){
    // this.paomaSliders = [];
    // this.api.getProductHeadlist({pageNum: 1,pageSize:30}).subscribe(f => {
    //   this.paomaSliders = f['list'];
    // }, err => {
    //   this.errorMessage=<any>err 
    // })
  }
  // 弹窗
  paomaClick(item){
    if(!item || !item.productId){
      return
    }
    this.api.getProductUrlById({productId: item.productId }).subscribe(f => {
      // 判断链接是否有协议，没有则加上
      if(f!=null && f['result'].indexOf('https://') === -1 && f['result'].indexOf('http://') === -1){
        item.productShortUrl = 'http://' + f['result']
      }else{
        item.productShortUrl = f['result']
      }
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPV',
        extraParam1: item.productId,//点击app的id
        extraParam2: '首页弹窗'
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
      let t;
      let data = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPR',
        extraParam1: item.productId,//点击app的id
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
  // 今日推荐金额补逗号
  toCurrencyString(str){
    return Number(str).toFixed(2).replace(/\d(?=(?:\d{3})+\b)/g,'$&,');
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
          console.log('File is fail')
        });
    }, err => {
      console.log('download is fail')
    });
  }
  closeLayer(){
    this.layer = false;
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
  loanClick(){
    if(!this.layerProductId){
      return
    }
    this.layer = false;

    this.api.getProductUrlById({productId: this.layerProductId }).subscribe(f => {
        
      // 判断链接是否有协议，没有则加上
      if(f!=null && f['result'].indexOf('https://') === -1 && f['result'].indexOf('http://') === -1){
        this.layerProductUrl = 'http://' + f['result']
      }else{
        this.layerProductUrl = f['result']
      }
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum'),
        event: 'APP_PPV',
        extraParam1: this.layerProductId,//点击app的id
        extraParam2: '首页弹窗'
      };
      this.options['title']['staticText'] = this.layerProductName;
      this.api.addEvent(params).subscribe(g => {
        console.log('APP点击埋点触发');
      }, err => {
        if(err == 401 || err == 500){
          window.localStorage.removeItem('phoneNum')
          this.events.publish('toLogin');
        }
      });
      // let paramsOrder = {
      //   phoneNum: window.localStorage.getItem('phoneNum'),
      //   productId: this.layerProductId
      // }
      // this.api.userClickProduct(paramsOrder).subscribe(c => {
      //   console.log('APP点击排序触发');
      // })
      this.browser = this.themeableBrowser.create(this.layerProductUrl, '_blank', this.options);
      let t;
      let data = {
        event: 'APP_PPR',
        phoneNum: window.localStorage.getItem('phoneNum'),
        extraParam1: this.layerProductId,//点击app的id
        extraParam2: '首页弹窗'
      }
      t = setTimeout(() => {
        this.api.addEvent(data).subscribe(h => {
          console.log('预计注册埋点触发');
        })
      }, 15000)
      this.browser.on('loadstart').subscribe(event => {
        if(event['url'].indexOf('.apk') > -1){
          this.userDate(event['url'], this.browser)
        }else if (event['url'].indexOf('fir.im') > -1){
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
  ionChange(){
  }
  //最近快报-更多
  more(){
    console.log('to more')
  }
  //下拉刷新
  doRefresh(refresher) {
    //console.log('Begin async operation', refresher);
    setTimeout(() => {
      this.todayRecommendConfig();
      this.getData3();
      this.getSoonData();
      this.getTodayRecommed()
      this.getPaoma();
      refresher.complete();
    }, 1000);
  }
  BindUserModule(){
    console.log('homepage done');
  }
  // 快捷口子点击
  productSoonItemSelected(item, index){
    console.log('item', item)
    console.log('index', index)
    let mappingPos = ['闪电下款', '芝麻分贷', '不查征信', '秒批口子', '小额快贷', '大额低息', '高通过率', '每日一款']
    if(!item || !item.productId){
      return
    }

    this.api.getProductUrlById({productId: item.productId }).subscribe(f => {
      // 判断链接是否有协议，没有则加上
    if(f!=null && f['result'].indexOf('https://') === -1 && f['result'].indexOf('http://') === -1){
      item.productShortUrl = 'http://' + f['result']
    }else{
      item.productShortUrl = f['result']
    }
    let params = {
      phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
      event: 'APP_PPV',
      extraParam1: item.productId,//点击app的id
      extraParam2: mappingPos[index]
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
    // let paramsOrder = {
    //   phoneNum: window.localStorage.getItem('phoneNum'),
    //   productId: item.productId
    // }
    // this.api.userClickProduct(paramsOrder).subscribe(c => {
    //   console.log('APP点击排序触发');
    // })
    this.browser = this.themeableBrowser.create(item.productShortUrl, '_blank', this.options);
    let t;
    let data = {
      phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
      event: 'APP_PPR',
      extraParam1: item.productId,//点击app的id
      extraParam2: mappingPos[index]
    }
    t = setTimeout(() => {
      this.api.addEvent(data).subscribe(h => {
        console.log('预计注册埋点触发');
      })
    }, 15000)
    this.browser.on('loadstart').subscribe(event => {
      if(event['url'].indexOf('.apk') > -1){
        this.userDate(event['url'], this.browser)
      }else if (event['url'].indexOf('fir.im') > -1){
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
  //今日推荐点击
  productItemSelected(){
    if(!this.todayRec || !this.todayRec.productId){
      return
    }
    this.api.getProductUrlById({productId: this.todayRec.productId }).subscribe(f => {
      // 判断链接是否有协议，没有则加上
      if(f !=null && f['result'].indexOf('http://') === -1 && f['result'].indexOf('https://') === -1){
        this.todayRec.productShortUrl = 'http://' +  f['result']
      }else{
        this.todayRec.productShortUrl =  f['result']
      }
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPV',
        extraParam1: this.todayRec.productId,//点击app的id
        extraParam2: '今日推荐'
      };
      this.options['title']['staticText'] = this.todayRec.productName;
      this.api.addEvent(params).subscribe(g => {
        console.log('APP点击埋点触发');
      }, err => {
        if(err == 401 || err == 500){
          window.localStorage.removeItem('phoneNum')
          this.events.publish('toLogin');
        }
      });
      // let paramsOrder = {
      //   phoneNum: window.localStorage.getItem('phoneNum'),
      //   productId: this.todayRec.productId
      // }
      // this.api.userClickProduct(paramsOrder).subscribe(c => {
      //   console.log('APP点击排序触发');
      // })
     
      this.browser = this.themeableBrowser.create(this.todayRec.productShortUrl, '_blank', this.options);
      let t;
      let data = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPR',
        extraParam1: this.todayRec.productId,//点击app的id
        extraParam2: '今日推荐'
      }
      t = setTimeout(() => {
        this.api.addEvent(data).subscribe(h => {
          console.log('预计注册埋点触发');
        })
      }, 15000)
      this.browser.on('loadstart').subscribe(event => {
        if(event['url'].indexOf('.apk') > -1){
          this.userDate(event['url'], this.browser)
        }else if (event['url'].indexOf('fir.im') > -1){
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
  // 轮播图图片点击
  slideItemClick(item){
    console.log('item', item)
    if(!item || !item.productId){
      return
    }

    this.api.getProductUrlById({productId: item.productId }).subscribe(f => {

        // 判断链接是否有协议，没有则加上
      if(f!=null && f['result'].indexOf('https://') === -1 && f['result'].indexOf('http://') === -1){
        item.productShortUrl = 'http://' + f['result']
      }else{
        item.productShortUrl = f['result']
      }
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPV',
        extraParam1: item.productId,//点击app的id
        extraParam2: '今日推荐'
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
      // let paramsOrder = {
      //   phoneNum: window.localStorage.getItem('phoneNum'),
      //   productId: item.productId
      // }
      // this.api.userClickProduct(paramsOrder).subscribe(c => {
      //   console.log('APP点击排序触发');
      // })
      this.browser = this.themeableBrowser.create(item.productShortUrl, '_blank', this.options);
      let t;
      let data = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPR',
        extraParam1: item.productId,//点击app的id
        extraParam2: '今日推荐'
      }
      t = setTimeout(() => {
        this.api.addEvent(data).subscribe(h => {
          console.log('预计注册埋点触发');
        })
      }, 15000)
      this.browser.on('loadstart').subscribe(event => {
        if(event['url'].indexOf('.apk') > -1){
          this.userDate(event['url'], this.browser)
        }else if (event['url'].indexOf('fir.im') > -1){
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
  //产品点击
  itemSelected(item, i){
  
    if(!item || !item.productId){
      return
    }
    //更新界面数据
    // this.productArr.push(this.productArr.splice(i, 1)[0]);
   
    this.api.getProductUrlById({productId: item.productId }).subscribe(f => {
     
      // 判断链接是否有协议，没有则加上
      if(f!=null && f['result'].indexOf('https://') === -1 && f['result'].indexOf('http://') === -1){
        item.productShortUrl = 'http://' + f['result']
      }else{
        item.productShortUrl = f['result']
      }
      let params = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPV',
        extraParam1: item.productId,//点击app的id
        extraParam2: '为您推荐'
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
      let t;
      let data = {
        phoneNum: window.localStorage.getItem('phoneNum'),   //用户id
        event: 'APP_PPR',
        extraParam1: item.productId,//点击app的id
        extraParam2: '为您推荐'
      }
      t = setTimeout(() => {
        this.api.addEvent(data).subscribe(h => {
          console.log('预计注册埋点触发');
        })
      }, 15000)
      this.browser.on('loadstart').subscribe(event => {
        if(event['url'].indexOf('.apk') > -1){
          this.userDate(event['url'], this.browser)
        }else if (event['url'].indexOf('fir.im') > -1){
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
  //查看全部产品
  checkAllProd(){
    this.navCtrl.parent.select(1);
  }
  // 每日签到
  signin(){
    this.navCtrl.parent.select(2);
  }
  getData3(){
    this.productArr = [];
    let params = {
      pageNum: 1,
      pageSize:30,
      isAndroid: Number(window.localStorage.getItem('androidVisited')) || 0,
      isIos: Number(window.localStorage.getItem('iosVisited')) || 0
    }
    this.api.getJqbList(params).subscribe(f => {
      this.productArr = f['list'] || []
    }, err => {
      this.errorMessage=<any>err
    })
  }
  layerData(){
    // layerProductUrl
    // layerProductId
    // layerProductName
    // let params = {
    //   isAndroid: Number(window.localStorage.getItem('androidVisited')) || 0,
    //   isIos: Number(window.localStorage.getItem('iosVisited')) || 0
    // }
    // this.api.getWindowProduct(params).subscribe(f => {
    //   if(!f['result']){
    //     this.layer = false
    //     return
    //   }
    //   console.log('fff', f);
     
    //   this.layerProductId = f['result']['productId'];
    //   this.layerProductName = f['result']['productName'];
    //   if(this.layerProductId ){
    //     this.layer = true
    //   }else{
    //     this.layer = false
    //   }
    // }, err => {
    //   this.errorMessage=<any>err
    // })
  }
  getSoonData(){
    // let params = {
    //   isAndroid: Number(window.localStorage.getItem('androidVisited')) || 0,
    //   isIos: Number(window.localStorage.getItem('iosVisited')) || 0
    // }
    // this.api.getMiaoPi(params).subscribe(f => {
    //   console.log('ffff1', f)
    //   if(f && f.length){
    //     for(let i = 0; i < f.length; i++){
    //       if(f[i]['secondBatchSwitch']){
    //         this.productSoonUrl1 = f[i]
    //       }
    //       if(f[i]['zmSwitch']){
    //         this.productSoonUrl2 = f[i]
    //       }
    //       if(f[i]['noValidateSwitch']){
    //         this.productSoonUrl3 = f[i]
    //       }
    //       if(f[i]['idcardLoanSwitch']){
    //         this.productSoonUrl4 = f[i]
    //       }
    //       if(f[i]['smallLoanSwitch']){
    //         this.productSoonUrl5 = f[i]
    //       }
    //       if(f[i]['bigMoneySwtich']){
    //         this.productSoonUrl6 = f[i]
    //       }
    //       if(f[i]['morePassSwitch']){
    //         this.productSoonUrl7 = f[i]
    //       }
    //       if(f[i]['oneDailySwitch']){
    //         this.productSoonUrl8 = f[i]
    //       }
    //     }
    //   }
    // }, err => {
    //   this.errorMessage=<any>err
    // })
  }
  // 激活埋点
  activeEvent(){
    let params = {
      'event': 'APP_FPV',
      'phoneNum': window.localStorage.getItem('phoneNum')
    }
    this.api.addEvent(params).subscribe(g => {
      console.log('首页激活埋点触发', g);
    }, err => {
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        this.events.publish('toLogin');
      }
    })
  }
  getTodayRecommed(){
    let params = {
      isAndroid: Number(window.localStorage.getItem('androidVisited')) || 0,
      isIos: Number(window.localStorage.getItem('iosVisited')) || 0
    }
    this.api.getTodayRecommed(params).subscribe(z => {
      console.log('z', z)
      this.todayRec.productName = z[0] && z[0]['productName']
      this.todayRec.shortContent = z[0] && z[0]['shortContent']
      this.todayRec.loanUpper = z[0] && z[0]['loanUpper']
      this.todayRec.applyNum = z[0] && z[0]['applyNum']
      // this.todayRec.productShortUrl = z[0]['productShortUrl']
      // this.todayRec.productUrl = z[0]['productUrl']
      this.todayRec.productId = z[0] && z[0]['productId']
      if(z && z.length > 1){
        this.slideArr = z && z.length && z.slice(1, z.length)
      }
    }, err => {
      this.errorMessage=<any>err
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        this.events.publish('toLogin');
      }
    })
  }
  todayRecommendConfig(){
    // this.api.getAppShowConfig({}).subscribe(g => {
    //   console.log('g', g[0]['isShow'])
    //   if(g && g.length){
    //     for(let i = 0; i < g.length; i++){
    //       if (g[i]['showArea'] === 'TODAY_RECOMMEND_SHOW'){
    //         this.todayRecommendShow = g[i]['isShow']
    //       }
    //       if (g[i]['showArea'] === 'SMALL_1'){
    //         this.line_1 = g[i]['isShow']
    //       }
    //       if (g[i]['showArea'] === 'SMALL_2'){
    //         this.line_2 = g[i]['isShow']
    //       }
    //       if (g[i]['showArea'] = 'BOTTOM_SHOW'){
    //         this.bottomText = g[i]['showAreaName'] || '查看全部产品'
    //       }
    //     }
    //   }
    // }, err => {
    //   this.errorMessage=<any>err
    //   if(err == 401 || err == 500){
    //     window.localStorage.removeItem('phoneNum')
    //     this.events.publish('toLogin');
    //   }
    // })
  }
  
  // 钩子函数，只加载一次
  ionViewDidLoad(){
    this.isShowDialog()
    this.todayRecommendConfig();
    this.layerData();
    this.getTodayRecommed();
    this.getSoonData();
    this.getData3();
    this.getPaoma();
    this.activeEvent();
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
        setTimeout(() => {
          this.child1.getDialogProd()
          let a = this.element.nativeElement.querySelector('.scroll-content').scrollHeight
          this.element.nativeElement.querySelector('.dialog-s').style.height = a + 'px';
        }, 0)
      }
    }, err => {
      this.errorMessage=<any>err 
    })
  }
  outpust($event) {
    console.log('outpust', $event)
    this.dialogS = false
  }
  // 钩子函数 -- 进入页面之后
  ionViewDidEnter(){
    this.slides.autoplayDisableOnInteraction = false;
    this.slides.startAutoplay();
    // console.log('model', this.device.model) //设备机型
    // console.log('platform', this.device.platform)//设备系统
    // console.log('uuid', this.device.uuid)
    // console.log('version', this.device.version)
    // console.log('manufacturer', this.device.manufacturer)
    // console.log('isVirtual', this.device.isVirtual)
    // console.log('serial', this.device.serial)
    // setTimeout(() => { // 测试启动
    //   this.child1.getDialogProd()
    //   let a = this.element.nativeElement.querySelector('.scroll-content').scrollHeight
    //   this.element.nativeElement.querySelector('.dialog-s').style.height = a + 'px';
    // }, 0)
  }
  ngAfterViewChecked(){
    // if(this.layer){
    //   let a = this.element.nativeElement.querySelector('.paoma').clientHeight + this.element.nativeElement.querySelector('.today-recommend-wrap').clientHeight + this.element.nativeElement.querySelector('.product-recommend').clientHeight + this.element.nativeElement.querySelector('.soon').clientHeight + 6;
    //   if(a > document.documentElement.clientHeight){
    //     this.element.nativeElement.querySelector('.layer').style.height = a + 'px';
    //   }else{
    //     this.element.nativeElement.querySelector('.layer').style.height = document.documentElement.clientHeight + 'px';
    //   }
    //   $(function (){
    //     $(".radio-item").click(function(){
    //       $(this).addClass("active").siblings().removeClass("active");
    //     });
    //   });
    // }
  }
  // 钩子函数 -- 离开页面之后
  ionViewDidLeave(){
    this.slides.stopAutoplay();
  }
}
