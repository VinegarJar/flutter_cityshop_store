import { Component } from '@angular/core';
import { NavController, NavParams, Events, ToastController } from 'ionic-angular';
import { ApiProvider } from '../../../providers/api/api';
import { BaseUI } from '../../../common/baseui';
// @IonicPage()
@Component({
  selector: 'page-complaint',
  templateUrl: 'complaint.html',
})
export class ComplaintPage extends BaseUI {
  errorMessage: any;
  remarks: string = '';
  constructor(public navCtrl: NavController,
              public navParams: NavParams,
              public events: Events,
              public api: ApiProvider,
              public toastCtrl: ToastController
    ) {
      super();
  }
  submit(){
    let params = {
      productName: '',
      remarks: this.remarks
    }
    if (!params.remarks) {
      super.showToast(this.toastCtrl, '请输入必填项');
      return
    }
    this.api.addComplaint(params).subscribe(f => {
    this.remarks = ''
    super.showToast(this.toastCtrl, '提交成功');
    }, err => {
      this.errorMessage=<any>err;
      if(err == 401 || err == 500){
        window.localStorage.removeItem('phoneNum');
        this.events.publish('toLogin');
      }
    })
  }
}