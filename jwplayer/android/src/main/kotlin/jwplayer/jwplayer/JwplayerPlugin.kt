package jwplayer.jwplayer

import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.LifecycleOwner
import com.jwplayer.pub.api.license.LicenseUtil

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

enum class Method {
  create, `init`, getPlatformVersion, play
}

/** JwplayerPlugin */
class JwplayerPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, AppCompatActivity() {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var flutterBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
      val lifecycle = binding.activity as LifecycleOwner
      flutterBinding.platformViewRegistry.registerViewFactory("<platform-view-type>", PlayerViewFactory(binding.activity, lifecycle))
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jwplayer")
    channel.setMethodCallHandler(this)
    flutterBinding = flutterPluginBinding
    LicenseUtil().setLicenseKey(flutterPluginBinding.applicationContext, "lxy7ShJpIaSeWAdw7/EgsXl9utA7g5D6L1XRRtH+XjHBHeDiYMzehjbCZ5WkLZo7snMuDH5cW29NVkti")
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    if (!Method.values().map { it.name }.contains(call.method)) {
      result.notImplemented()
      return
    }

    when (Method.valueOf(call.method)) {
      Method.create -> result.success(1)
      Method.init -> result.success("init")
      Method.getPlatformVersion -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      Method.play -> result.success("play")
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    val lifecycle = binding.activity as LifecycleOwner
    flutterBinding.platformViewRegistry.registerViewFactory("<platform-view-type>", PlayerViewFactory(binding.activity, lifecycle))
  }

  override fun onDetachedFromActivity() {

  }
}

