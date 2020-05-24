package com.example.screenlock;

import android.annotation.TargetApi;
import android.content.Context;
import android.media.AudioManager;
import android.os.Build;
import android.os.Bundle;
import android.view.KeyEvent;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private  static  final String CHANNEL = "samples.flutter.io/contact";

  @TargetApi(Build.VERSION_CODES.M)
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
                @Override
                public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                    if (methodCall.method.equals ("hideVolume")){
                    KeyEvent key = methodCall.arguments();
                    int dat = key.getKeyCode();
                    onKeyDown(dat, key);}
                }
            }
    );
  }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if ((keyCode == KeyEvent.KEYCODE_VOLUME_DOWN)){
            //Do something to hide the view
            AudioManager manager = (AudioManager)this.getSystemService(Context.AUDIO_SERVICE);
            manager.adjustVolume(AudioManager.ADJUST_LOWER, 0);
        }
        if ((keyCode == KeyEvent.KEYCODE_VOLUME_UP)){
            //Do something to hide the view
            AudioManager manager = (AudioManager)this.getSystemService(Context.AUDIO_SERVICE);
            manager.adjustVolume(AudioManager.ADJUST_LOWER, 0);
        }
        return true;
    }
}
