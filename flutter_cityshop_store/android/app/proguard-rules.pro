-keep class com.shockwave.**
-keepclassmembers class com.store.applyslug.** { 
    public static final int *;
 }
 
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keepattributes *Annotation*
-keep class com.umeng.** {*;}
-dontwarn com.umeng.**