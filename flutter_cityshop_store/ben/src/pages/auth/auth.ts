import { Component, ViewChild, ElementRef } from '@angular/core';
import { NavController, NavParams, ToastController, LoadingController, Events, Navbar } from 'ionic-angular';
import {Camera, CameraOptions} from "@ionic-native/camera";
import { BaseUI } from '../../common/baseui';
import { FileTransfer, FileUploadOptions, FileTransferObject } from '@ionic-native/file-transfer';
import { ApiProvider } from '../../providers/api/api';
import { BasicinfoPage2 } from '../authlist/basicinfo2/basicinfo2'
import { DialogPrdComponent } from '../../components/dialog-prd/dialog-prd'
/**
 * Generated class for the AuthPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

// @IonicPage()
@Component({
  selector: 'page-auth',
  templateUrl: 'auth.html',
})
export class AuthPage extends BaseUI {
  @ViewChild(Navbar) navbar: Navbar;
  @ViewChild('child1')
  child1: DialogPrdComponent;
  public idNum: String;
  public idFrontImg: String;
  public idBackImg: String;
  path = '';
  public idFrontUuid = '';
  public idBackUuid = '';
  errorMessage:any;
  public dialogS: Boolean = false;
  public canLeave:boolean = false;
  constructor(public navCtrl: NavController,
    public navParams: NavParams,
    public camera: Camera,
    public toastCtrl: ToastController,
    public loadingCtrl: LoadingController,
    private transfer: FileTransfer,
    // private file: File,
    public events: Events,
    public api: ApiProvider,
    public element: ElementRef
    ) {
    super();
  }
  openCamera(picType: string){
    const options: CameraOptions = {
      quality: 50,                                                   //相片质量 0 -100
      allowEdit: true,
      targetWidth: 200,
      targetHeight: 200,
      destinationType: this.camera.DestinationType.DATA_URL,        //DATA_URL 是 base64   FILE_URI 是文件路径
      encodingType: this.camera.EncodingType.JPEG,
      mediaType: this.camera.MediaType.PICTURE,
      saveToPhotoAlbum: true,                                       //是否保存到相册
      sourceType: this.camera.PictureSourceType.CAMERA,         //是打开相机拍照还是打开相册选择  PHOTOLIBRARY : 相册选择, CAMERA : 拍照,
    }

    this.camera.getPicture(options).then((imageData) => {
      console.log("got file: " + imageData);

      // If it's base64:
      let base64Image = 'data:image/jpeg;base64,' + imageData;
      console.log('base64Image=' + base64Image);
      this.path = base64Image;

      //If it's file URI
      this.upload(picType);

    }, (err) => {
      // Handle error
      super.showToast(this.toastCtrl, '拍摄失败，请重试！');
    });
  }
  upload(picType: string) {
    let apiPath = ''
    if(picType === 'front'){
      apiPath = this.api.uploadFileToOssFront;
    }else{
      apiPath = this.api.uploadFileToOssBack;
    }
    const fileTransfer: FileTransferObject = this.transfer.create();
    let options: FileUploadOptions = {
      fileKey: 'file',
      fileName: 'avatar.jpg',
      headers: {},
      params: {
        // picFile: this.path
        realNameNeed: window.localStorage.getItem('realNameNeed')
      }
    }
    let loading = super.showLoading(this.loadingCtrl, "上传中...")
    fileTransfer.upload(this.path, apiPath, options)
      .then((res) => {
        loading.dismiss()
        let result =  eval('(' + res['response'] + ')');
        let uuid = '';
        if (picType === 'front') {
          if(result['code'] === 200){
            uuid = `https://myfq.oss-cn-shenzhen.aliyuncs.com/${result['result']['picUrl']}`;
            this.idNum = result['result']['idcard'];
            this.idFrontImg = uuid;
            this.idFrontUuid = uuid;
          }else{
            super.showToast(this.toastCtrl, result['msg'])
            return
          }
        } else {
          if(result['code'] === 500){
            super.showToast(this.toastCtrl, result['msg'])
            return
          }
          uuid = `https://myfq.oss-cn-shenzhen.aliyuncs.com/${result['result']}`;
          this.idBackImg = uuid;
          this.idBackUuid = uuid;
        }
        super.showToast(this.toastCtrl, '图片上传成功');
      }, (err) => {
        loading.dismiss()
        super.showToast(this.toastCtrl, '系统故障，请稍后再试');
        if(err == 401 || err == 500){
          window.localStorage.removeItem('phoneNum')
          // this.events.publish('toLogin');
        }
      });
  }
  realnameAuth(){
    console.log('idFrontUuid:' + this.idFrontUuid + '  idBackUuid:' + this.idBackUuid);
    if (this.idFrontUuid.length == 0) {
      super.showToast(this.toastCtrl, '请上传身份证人像面照片');
      return;
    }
    if (this.idBackUuid.length == 0) {
      super.showToast(this.toastCtrl, '请上传身份证国徽面照片');
      return;
    }
    // this.navCtrl.push(BasicinfoPage2)
    let params = {
      idNum: this.idNum,
      idcardFaceUrl: this.idFrontUuid,
      idcardBackUrl: this.idBackUuid
    };
    let loading = super.showLoading(this.loadingCtrl, "提交中");
    this.api.xjdSaveRealInfo(params).subscribe(f => {
      loading.dismiss();
      this.canLeave = true
      window.localStorage.setItem('realNameVerify', '1');
      this.navCtrl.push(BasicinfoPage2)
    }, err => {
      loading.dismiss();
      super.showToast(this.toastCtrl, '提交失败, 请重试');
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum')
        // this.events.publish('toLogin');
      }
    })
  }
   //文件下载
  //  download() {
  //   const fileTransfer: FileTransferObject = this.transfer.create();
  //   const url ="http://www.example.com/file.pdf";
  //   fileTransfer.download(url, this.file.dataDirectory + 'file.jpg').then((entry) => {
  //     this.image1=entry.toURL();
  //   }, (error) => {
  //     alert("download失败")
  //   });
  // }
  ionViewDidLoad() {
    this.idFrontImg = 'assets/imgs/id_front.png';
    this.idBackImg = 'assets/imgs/id_back.png';
    this.navbar.backButtonClick = (e)=>{
      this.isShowDialog()
    };
  }
  ionViewCanLeave() {
    return this.canLeave;
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
      } else {
        this.canLeave = true
        this.navCtrl.pop()
      }
    }, err => {
      this.errorMessage=<any>err 
    })
  }
  outpust($event) {
    console.log('outpust', $event)
    this.dialogS = false
    this.canLeave = true
    this.navCtrl.pop()
  }

}
