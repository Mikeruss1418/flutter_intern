
package com.example.platform_channel

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "platform_channel_testing"
    private  val REQUEST_CODE_SECOND =201//unique code to Start activity
    private val REQUEST_CODE_FIRST = 200
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
        startActivityForResult(intent,REQUEST_CODE_FIRST)
    }

    private fun openNativeScreenB(message: String?) {
        val intent = Intent(this, SecondNativeActivity::class.java)
        intent.putExtra("msg", message)
//        startActivityForResult(intent,REQUEST_CODE)
        startActivityForResult(intent,REQUEST_CODE_SECOND)
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_FIRST && resultCode == RESULT_OK) {
            val returnedData = data?.getStringExtra("returned_data") ?: "No data returned"
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).invokeMethod("onDataReceived", returnedData)
        }
        else if (requestCode == REQUEST_CODE_SECOND && resultCode == RESULT_OK) {
            val returnData = data?.getStringExtra("returned_to")?:"No data returned 01"
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).invokeMethod("onDataReceived01",returnData)
        }
    }


}

