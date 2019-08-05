package com.creepersan.flutter_weather.bridge

import android.content.Context
import android.content.SharedPreferences
import com.creepersan.flutter_weather.WeatherApp
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class SharedPreferenceChannel : MethodChannel.MethodCallHandler{
    companion object{
        val CHANNEL_NAME = "com.creepersan.flutter_weather/SharedPreferenceChannel"

        private const val METHOD_GET_VALUE = "getPref"
        private const val METHOD_SET_VALUE = "setPref"

        private const val PARAMS_TABLE = "table"
        private const val PARAMS_KEY = "key"
        private const val PARAMS_VALUE = "value"
        private const val PARAMS_DEFAULT = "default"

        private const val DEFAULT_TABLE = "FlutterWeather"
    }

    private val mPrefMap = HashMap<String, SharedPreferences>()

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        call ?: return
        result ?: return
        println("【Native】 OnMethodCall   ->   call.method:${call.method}     call.argument:${call.arguments}")
        when(call.method){
            METHOD_GET_VALUE -> handelGetValue(call, result)
            METHOD_SET_VALUE -> handelSetValue(call, result)
        }
    }

    private fun handelGetValue(call: MethodCall, result: MethodChannel.Result){
        val jsonStr = call.arguments as String
        val json = JSONObject(jsonStr)
        val table = json.optString(PARAMS_TABLE, DEFAULT_TABLE)
        val key = json.optString(PARAMS_KEY)
        val default = json.optString(PARAMS_DEFAULT)

        if (key == "") result.error(CHANNEL_NAME, "写入数据缺少键值", Unit)

        result.success(getValue(table, key, default))
    }

    private fun handelSetValue(call: MethodCall, result: MethodChannel.Result){
        val jsonStr = call.arguments as String
        val json = JSONObject(jsonStr)
        val table = json.optString(PARAMS_TABLE, DEFAULT_TABLE)
        val key = json.optString(PARAMS_KEY)
        val value = json.optString(PARAMS_VALUE)

        if (key == "") result.error(CHANNEL_NAME, "写入数据缺少键值", Unit)

        setValue(table, key, value)

        result.success(0)
    }

    private fun getPref(table:String):SharedPreferences{
        if(mPrefMap.containsKey(table)){
            return mPrefMap[table] !!
        }else{
            mPrefMap[table] = WeatherApp.getInstance().getSharedPreferences(table, Context.MODE_PRIVATE)
            return mPrefMap[table] !!
        }
    }

    private fun setValue(table:String, key:String, value:String){
        getPref(table).edit().putString(key, value).commit()
    }

    private fun getValue(table:String, key: String, default: String=""):String{
        return getPref(table).getString(key, default)
    }
}