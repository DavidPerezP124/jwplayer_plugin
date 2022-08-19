package jwplayer.jwplayer

import android.app.Activity
import android.content.Context
import android.widget.LinearLayout
import androidx.lifecycle.LifecycleOwner
import com.jwplayer.pub.view.JWPlayerView


class PlayerLayout (
    context: Context,
    /**
     * App main activity
     */
    private val activity: Activity,

    private val owner: LifecycleOwner
) :
    LinearLayout(context) {

    var mPlayerView: JWPlayerView? = null

    private fun initPlayer() {
        mPlayerView = JWPlayerView(context)
    }

    init {
        initPlayer()
    }
}

