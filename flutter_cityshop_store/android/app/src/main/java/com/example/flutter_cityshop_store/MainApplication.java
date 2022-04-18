package com.cityshop.cityshop_store;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import io.flutter.app.FlutterApplication;
import com.umeng.commonsdk.UMConfigure;
import android.content.SharedPreferences;

public class MainApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();

        SharedPreferences sp = getSharedPreferences("FlutterSharedPreferences", this.MODE_PRIVATE);
        String policy = sp.getString("policy","");
        if (policy.equals("1")){
            UMConfigure.init(this, "61a07a2fe014255fcb8d33bc", "Umeng", UMConfigure.DEVICE_TYPE_PHONE, null);
            UMConfigure.setLogEnabled(true);
            android.util.Log.i("UMLog", "UMConfigure.init@MainApplication");
        }

    }
}