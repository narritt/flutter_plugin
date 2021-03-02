package com.narritt.magic

import android.app.Dialog
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** MagicPlugin */
class MagicPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "magic")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "getPlatformVersion" -> {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        "showDialog" -> {
            val dialog = Dialog(context)
            dialog.setTitle("Dialog")
            dialog.show()
        }
        "generateColor" -> {
            val color = generateColor()
            result.success(color)
        }
        "parseNumber" -> {
            val arguments = call.arguments as ArrayList<*>
            val num : Int = arguments[0] as Int
            result.success(num)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  private fun generateColor(): List<Int> {
      return arrayOf(0, 0, 0).map { (Math.random() * 256).toInt() }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
