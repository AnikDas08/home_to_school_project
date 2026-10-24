package com.example.home_to_school

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val DIALER_CHANNEL = "com.example.home_to_school/dialer"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DIALER_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openDialer") {
                val number = call.argument<String>("number")
                if (!number.isNullOrEmpty()) {
                    try {
                        val intent = Intent(Intent.ACTION_DIAL).apply {
                            data = Uri.parse("tel:$number")
                            flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        }
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("DIALER_ERROR", e.localizedMessage, null)
                    }
                } else {
                    result.error("INVALID_NUMBER", "Phone number is null or empty", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
