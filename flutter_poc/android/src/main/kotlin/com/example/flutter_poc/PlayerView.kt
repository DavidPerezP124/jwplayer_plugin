package com.example.flutter_poc_example

import android.app.Activity
import android.content.Context
import android.view.View
import androidx.lifecycle.LifecycleOwner
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


internal class PlayerView(context: Context?,
                          activity: Activity?,
                          id: Int, owner: LifecycleOwner) : PlatformView {
    private var playerView: View

    init {
        playerView = ViewLayout(context!!, activity!!, owner)
        playerView.id = id
    }

    override fun getView(): View {
        return playerView
    }

    override fun dispose() {}
}