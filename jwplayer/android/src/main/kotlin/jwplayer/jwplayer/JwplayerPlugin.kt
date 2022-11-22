package jwplayer.jwplayer

import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.LifecycleOwner
import com.jwplayer.pub.api.license.LicenseUtil

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.systemchannels.KeyEventChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** JwplayerPlugin */
class JwplayerPlugin: FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler,  ActivityAware, AppCompatActivity() {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var messenger: BinaryMessenger
  private lateinit var flutterBinding: FlutterPlugin.FlutterPluginBinding
  private lateinit var eventChannel: EventChannel
  private var eventSink: QueueEventSink = QueueEventSink()

  private enum class Method {
    `init`, getPlatformVersion, setLicenseKey
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
      val lifecycle = binding.activity as LifecycleOwner
      val factory = PlayerViewFactory(binding.activity, lifecycle, messenger, eventSink)
      val viewChannel = MethodChannel(messenger, "playerview")
      viewChannel.setMethodCallHandler(factory)
      flutterBinding.platformViewRegistry.registerViewFactory("<platform-view-type>", factory)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    messenger = flutterPluginBinding.binaryMessenger
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jwplayer")
    channel.setMethodCallHandler(this)

    eventChannel = EventChannel(messenger, "com.jwplayer.view")
    eventChannel.setStreamHandler(this)
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
    flutterBinding.platformViewRegistry.registerViewFactory("<platform-view-type>", PlayerViewFactory(binding.activity, lifecycle, messenger, eventSink))
  }

  override fun onDetachedFromActivity() {

  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink.setListener(events)
  }

  override fun onCancel(arguments: Any?) {
    eventSink.setListener(null)
  }
}

