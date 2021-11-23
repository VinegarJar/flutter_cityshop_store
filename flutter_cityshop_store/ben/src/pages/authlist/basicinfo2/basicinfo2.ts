import { Component, ViewChild, ElementRef } from '@angular/core';
import { NavController, LoadingController, ToastController, Events, Navbar } from 'ionic-angular';
import { BaseUI } from '../../../common/baseui';
import { ApiProvider } from '../../../providers/api/api';
import { ResultPage } from '../result/result';
import { DialogPrdComponent } from '../../../components/dialog-prd/dialog-prd'
// @IonicPage()
@Component({
  selector: 'page-basicinfo2',
  templateUrl: 'basicinfo2.html'
})
export class BasicinfoPage2 extends BaseUI{
  @ViewChild(Navbar) navbar: Navbar;
  @ViewChild('child1')
  child1: DialogPrdComponent;
  public shenheye:any = true;
  public readonly: any = false;
  public hunyin: string = '';
  public companyAddress: string = '';
  public companyCity: string = '';
  public companyName: string = '';
  public companyPhone: string = '';
  public education: any = null;
  public email: string = '';
  public firstContactName: string = '';
  public firstContactPhoneNum: string = '';
  public firstContactRelation: string = '';
  public loanReason: string = '';
  public occupation: string = '';
  public otherLoanMoney: string = '';
  public presentAddress: string = '';
  public presentCity: string = '';
  public workIncome: string = '';
  public married: string = '';
  errorMessage:any;
  public dialogS: Boolean = false;
  public canLeave:boolean = false;
  constructor(public navCtrl: NavController,
              public loadingCtrl: LoadingController,
              public toastCtrl: ToastController,
              public api: ApiProvider,
              public events: Events,
              public element: ElementRef
              ) {
    super();
  }
  ionViewDidLoad(){
    this.navbar.backButtonClick = (e)=>{
      this.isShowDialog()
    };
  }
  // 进入页面之前
  ionViewDidEnter(){
    // this.api.getBasicInfo({}).subscribe(f => {
    //   console.log('bankinfo', f);
    //   let res = f['result'];
    //   this.companyAddress = res.companyAddress;
    //   this.companyCity = res.companyCity;
    //   this.companyName = res.companyName;
    //   this.companyPhone = res.companyPhone;
    //   this.education = res.education;
    //   this.email = res.email;
    //   this.firstContactName = res.firstContactName;
    //   this.firstContactPhoneNum = res.firstContactPhoneNum;
    //   this.firstContactRelation = res.firstContactRelation;
    //   this.loanReason = res.loanReason;
    //   this.occupation = res.occupation;
    //   this.otherLoanMoney = res.otherLoanMoney;
    //   this.presentAddress = res.presentAddress;
    //   this.presentCity = res.presentCity;
    //   this.workIncome = res.workIncome;
    // })
    // this.api.getAuthInfo({}).subscribe(f => {
    //   if(f['basicInfoVerify']){
    //     this.readonly = true;
    //   }else{
    //     this.readonly = false;
    //   }
    // },err => {
    // })
  }
  submitClick(){
    if(!this.firstContactName.length ||
      !this.firstContactPhoneNum.length || !this.firstContactRelation.length){
        super.showToast(this.toastCtrl, '请填写必填项');
        return
    }
    this.canLeave = true
    this.navCtrl.push(ResultPage)
    // this.navCtrl.push()
    // let params = {
    //   "companyAddress": this.companyAddress,
    //   "companyCity": this.companyCity,
    //   "companyName": this.companyName,
    //   "companyPhone": this.companyPhone,
    //   "education": Number(this.education),
    //   "email": this.email,
    //   "firstContactName": this.firstContactName,
    //   "firstContactPhoneNum": this.firstContactPhoneNum,
    //   "firstContactRelation": this.firstContactRelation,
    //   "loanReason": this.loanReason,
    //   "occupation": this.occupation,
    //   "otherLoanMoney": this.otherLoanMoney,
    //   "presentAddress": this.presentAddress,
    //   "presentCity": this.presentCity,
    //   "workIncome": this.workIncome
    // }
    // this.api.basicInfo(params).subscribe(f => {
    //   this.navCtrl.pop()
    // }, err => {
    //   super.showToast(this.toastCtrl, '提交失败，请重试');
    //   if(err == 401 || err == 500){
    //     window.localStorage.removeItem('phoneNum')
    //     // this.events.publish('toLogin');
    //   }
    // })
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
      }else{
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