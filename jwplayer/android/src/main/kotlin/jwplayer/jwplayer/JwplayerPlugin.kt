package jwplayer.jwplayer

import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.LifecycleOwner
import com.jwplayer.pub.api.license.LicenseUtil

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** JwplayerPlugin */
class JwplayerPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, AppCompatActivity() {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var messenger: BinaryMessenger
  private lateinit var flutterBinding: FlutterPlugin.FlutterPluginBinding

  private enum class Method {
    `init`, getPlatformVersion, setLicenseKey
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
      val lifecycle = binding.activity as LifecycleOwner
      val factory = PlayerViewFactory(binding.activity, lifecycle, messenger)
      val viewChannel = MethodChannel(messenger, "playerview")
      viewChannel.setMethodCallHandler(factory)
      flutterBinding.platformViewRegistry.registerViewFactory("<platform-view-type>", factory)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    messenger = flutterPluginBinding.binaryMessenger
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jwplayer")
    channel.setMethodCallHandler(this)
    flutterBinding = flutterPluginBinding
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    if (!Method.values().map { it.name }.contains(call.method)) {
      result.notImplemented()
      return
    }

    when (Method.valueOf(call.method)) {
      Method.init -> result.success("init")
      Method.getPlatformVersion -> result.success("4.6.0")
      Method.setLicenseKey -> { 
        val key = call.argument<String>("licenseKey")
        LicenseUtil().setLicenseKey(flutterBinding.applicationContext, key)
      }
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
    flutterBinding.platformViewRegistry.registerViewFactory("<platform-view-type>", PlayerViewFactory(binding.activity, lifecycle, messenger))
  }

  override fun onDetachedFromActivity() {

  }
}

