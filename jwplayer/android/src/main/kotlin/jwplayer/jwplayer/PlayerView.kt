package jwplayer.jwplayer

import android.app.Activity
import android.content.Context
import android.view.View
import androidx.lifecycle.LifecycleOwner
import com.jwplayer.pub.api.JWPlayer
import com.jwplayer.pub.api.configuration.PlayerConfig
import com.jwplayer.pub.view.JWPlayerView
import io.flutter.Log
import io.flutter.plugin.platform.PlatformView


internal class PlayerView(context: Context?,
                          activity: Activity?,
                          id: Int, owner: LifecycleOwner) : PlatformView, PlayerInterface {
    private var playerView: JWPlayerView
    private var mPlayer: JWPlayer? = null
    private lateinit var config: PlayerConfig
    init {
        val layout = PlayerLayout(context!!, activity!!, owner)
        playerView = layout.mPlayerView!!
        playerView.id = id
        playerView!!.getPlayerAsync(
            context,
            owner,
            JWPlayer.PlayerInitializationListener { jwPlayer: JWPlayer ->
                mPlayer = jwPlayer
                mPlayer?.setup(config)
            })
    }

    override fun getView(): View {
        playerView
        return playerView
    }

    override fun setConfig(config: PlayerConfig) {
        Log.d( "MainActivity", "DebugPrint: settingConfig: $mPlayer")
        this.config = config
        mPlayer?.setup(config)
    }

    override fun play() {
        mPlayer?.play()
    }

    override fun pause() {
        mPlayer?.pause()
    }

    override fun stop() {
        mPlayer?.stop()
    }

    override fun dispose() {
    }
}

interface PlayerInterface {
    fun setConfig(config: PlayerConfig)
    fun play()
    fun pause()
    fun stop()
}