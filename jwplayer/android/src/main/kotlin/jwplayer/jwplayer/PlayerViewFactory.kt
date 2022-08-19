package jwplayer.jwplayer

import android.app.Activity
import android.content.Context
import androidx.lifecycle.LifecycleOwner
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.json.JSONObject


class PlayerViewFactory(activity: Activity, owner: LifecycleOwner, messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE),
    MethodChannel.MethodCallHandler {

    private var currentActivity: Activity;
    private var viewOwner: LifecycleOwner;
    private var messenger: BinaryMessenger;
    private var channel: MethodChannel
    private var players = mutableMapOf<Int, PlayerInterface>()
    private var lastView: Int = 0

    private enum class Method {
        setConfig, play, pause, stop, create
    }

    init {
        currentActivity = activity;
        viewOwner = owner
        this.messenger = messenger;
        channel = MethodChannel(messenger, "playerview")
        channel.setMethodCallHandler(this)
    }
    override fun create(p0: Context?, p1: Int, p2: Any?): PlatformView {
        val creationParams = p2 as Map<String?, Any?>?
        val view = PlayerView(p0, currentActivity, p1, viewOwner)
        players[p1] = view
        lastView++
        return view
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (!Method.values().map { it.name }.contains(call.method)) {
            result.notImplemented()
            return
        }

        when (Method.valueOf(call.method)) {
            Method.play -> result.success("play")
            Method.create -> result.success(lastView)
            Method.setConfig -> {
                val config = call.argument<Map<String,Any>>("config")
                val id = call.argument<Int>("id")
                if (config != null ) {
                    print(players[id])
                    players[id]?.setConfig(ConfigurationBuilder().toPlayerConfig(JSONObject(config)))
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

}