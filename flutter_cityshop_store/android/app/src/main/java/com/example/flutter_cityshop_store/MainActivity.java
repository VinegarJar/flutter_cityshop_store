package com.cityshop.cityshop_store;

import io.flutter.embedding.android.FlutterActivity;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.umeng.analytics.MobclickAgent;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        MobclickAgent.setSessionContinueMillis(1000*40);
        android.util.Log.i("UMLog", "onCreate@MainActivity");
    }

    @Override
    protected void onPause() {
        super.onPause();
        MobclickAgent.onPause(this);
        android.util.Log.i("UMLog", "onPause@MainActivity");
    }

    @Override
    protected void onResume() {
        super.onResume();
        MobclickAgent.onResume(this);
        android.util.Log.i("UMLog", "onResume@MainActivity");
    }

}