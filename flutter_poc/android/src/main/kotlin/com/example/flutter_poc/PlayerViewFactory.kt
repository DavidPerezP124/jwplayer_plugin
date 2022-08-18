package com.example.flutter_poc_example

import android.app.Activity
import android.content.Context
import android.view.View
import androidx.lifecycle.LifecycleOwner
import com.jwplayer.pub.view.JWPlayerView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PlayerViewFactory(activity: Activity, owner: LifecycleOwner) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    private var currentActivity: Activity;
    private var viewOwner: LifecycleOwner;

    init {
        currentActivity = activity;
        viewOwner = owner
    }
    override fun create(p0: Context?, p1: Int, p2: Any?): PlatformView {
        val creationParams = p2 as Map<String?, Any?>?
        return PlayerView(p0, currentActivity, p1, viewOwner)
    }
}