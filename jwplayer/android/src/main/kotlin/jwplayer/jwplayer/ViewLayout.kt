package jwplayer.jwplayer

import android.app.Activity
import android.content.Context
import android.content.res.Configuration
import android.view.KeyEvent
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.lifecycle.LifecycleOwner
import com.jwplayer.pub.api.JWPlayer
import com.jwplayer.pub.api.configuration.PlayerConfig
import com.jwplayer.pub.view.JWPlayerView


class ViewLayout (
    context: Context,
    /**
     * App main activity
     */
    private val activity: Activity,

    private val owner: LifecycleOwner
) :
    LinearLayout(context) {
    /**
     * Reference to the [JWPlayerView]
     */
    private var mPlayerView: JWPlayerView? = null

    private var mPlayer: JWPlayer? = null
    /**
     * Reference to the [PlayerConfig]
     */
    private val playerConfig = PlayerConfig.Builder().build()

    /**
     * An instance of our event handling class
     */
    private fun initPlayer() {
        mPlayerView = JWPlayerView(context)
        this.addView(mPlayerView,0, LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT))
    }

    init {
        initPlayer()
        try {
        } catch (e: Exception) { /* ignore */
        }
    }
}