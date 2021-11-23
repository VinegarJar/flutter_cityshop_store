import { NgModule } from '@angular/core';
// import { IonicPageModule } from 'ionic-angular';
// import { AuthPage } from './auth';
import { ComponentsModule } from '../../components/components.module';

@NgModule({
  declarations: [
    // AuthPage,
  ],
  imports: [
    ComponentsModule
    // IonicPageModule.forChild(AuthPage),
  ],
})
export class AuthPageModule {}
