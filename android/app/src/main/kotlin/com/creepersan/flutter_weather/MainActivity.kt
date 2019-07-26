package com.creepersan.flutter_weather

import android.os.Bundle
import com.creepersan.flutter_weather.bridge.SharedPreferenceChannel

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, SharedPreferenceChannel.CHANNEL_NAME).setMethodCallHandler(SharedPreferenceChannel())
  }

}
