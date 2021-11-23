import { Injectable } from '@angular/core';
// import { Storage } from "@ionic/storage";
@Injectable()
export class GlobalData {
  constructor(){
    // this.storage.get('user_token').then((val) => {
    //   if(val){
    //     this.settoken(val);
    //   }
    // })
  }
  private _userId: string; // 用户id
  private _username: string; // 用户名
  private _user; // 用户详细信息
  private _token: string; // token

  get userId(): string {
    return this._userId;
  }

  set userId(value: string) {
    this._userId = value;
  }

  get username(): string {
    return this._username;
  }

  set username(value: string) {
    this._username = value;
  }

  get user() {
    return this._user;
  }

  set user(value) {
    this._user = value;
  }

  gettoken(): string {
    return this._token;
  }

  settoken(value: string) {
    this._token = value;
  }

}