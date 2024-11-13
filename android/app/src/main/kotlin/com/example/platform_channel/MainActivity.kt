
package com.example.platform_channel

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "platform_channel_testing"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openNativeScreenA" -> {
                    val message = call.argument<String>("msg")
                    openNativeScreenA(message)
                    result.success(null)
                }
                "openNativeScreenB" -> {
                    val message = call.argument<String>("msg")
                    openNativeScreenB(message)
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun openNativeScreenA(message: String?) {
        val intent = Intent(this, NativeActivity::class.java)
        intent.putExtra("msg", message)
        startActivity(intent)
    }

    private fun openNativeScreenB(message: String?) {
        val intent = Intent(this, SecondNativeActivity::class.java)
        intent.putExtra("msg", message)
        startActivity(intent)
    }
}

