package com.cityshop.cityshop_store;

import io.flutter.embedding.android.FlutterActivity;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
   
    }

    @Override
    protected void onPause() {
        super.onPause();
        
    }

    @Override
    protected void onResume() {
        super.onResume();
       
    }

}