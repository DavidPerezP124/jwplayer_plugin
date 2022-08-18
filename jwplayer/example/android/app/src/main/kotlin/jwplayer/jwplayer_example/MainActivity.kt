<<<<<<< HEAD:jwplayer/example/android/app/src/main/kotlin/jwplayer/jwplayer_example/MainActivity.kt
package jwplayer.jwplayer_example
=======

package com.example.flutter_poc_example
import androidx.appcompat.app.AppCompatActivity
import com.jwplayer.pub.api.license.LicenseUtil
>>>>>>> main:flutter_poc/example/android/app/src/main/kotlin/com/example/flutter_poc_example/MainActivity.kt

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity:  FlutterActivity()  {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        LicenseUtil().setLicenseKey(this, "lxy7ShJpIaSeWAdw7/EgsXl9utA7g5D6L1XRRtH+XjHBHeDiYMzehjbCZ5WkLZo7snMuDH5cW29NVkti")
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-type>", PlayerViewFactory(this, this))
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_poc").setMethodCallHandler {
            call, result ->
            if (call.method == "getPlatformVersion") {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            } else {
                result.notImplemented()
            }
        }
    }
}
