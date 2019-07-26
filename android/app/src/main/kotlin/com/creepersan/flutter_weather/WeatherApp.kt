package com.creepersan.flutter_weather

import android.annotation.SuppressLint
import android.app.Application
import io.flutter.app.FlutterApplication
import io.flutter.view.FlutterMain

class WeatherApp : FlutterApplication() {
    companion object{
        @SuppressLint("StaticFieldLeak")
        private lateinit var mInstance : WeatherApp

        fun getInstance():WeatherApp{
            return mInstance
        }
    }

    override fun onCreate() {
        super.onCreate()
        mInstance = this

        FlutterMain.startInitialization(this)
    }

}