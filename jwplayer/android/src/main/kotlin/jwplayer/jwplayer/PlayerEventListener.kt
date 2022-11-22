package jwplayer.jwplayer

import com.jwplayer.pub.api.events.*
import com.jwplayer.pub.api.events.listeners.*
import com.jwplayer.pub.api.events.EventType.*

class PlayerEventListener(private val eventSink: QueueEventSink) : AllEventListeners
    {

        //region Ad Events
    override fun onAdBreakEnd(p0: AdBreakEndEvent?) {
 
    }

    override fun onAdBreakIgnored(p0: AdBreakIgnoredEvent?) {
 
    }

    override fun onAdBreakStart(p0: AdBreakStartEvent?) {
 
    }

    override fun onAdClick(p0: AdClickEvent?) {
 
    }

    override fun onAdCompanions(p0: AdCompanionsEvent?) {
 
    }

    override fun onAdComplete(p0: AdCompleteEvent?) {
 
    }

    override fun onAdError(p0: AdErrorEvent?) {
 
    }

    override fun onAdImpression(p0: AdImpressionEvent?) {
 
    }

    override fun onAdMeta(p0: AdMetaEvent?) {
 
    }

    override fun onAdPause(p0: AdPauseEvent?) {
 
    }

    override fun onAdPlay(p0: AdPlayEvent?) {
 
    }

    override fun onAdRequest(p0: AdRequestEvent?) {
 
    }

    override fun onAdSchedule(p0: AdScheduleEvent?) {
 
    }

    override fun onAdSkipped(p0: AdSkippedEvent?) {
 
    }

    override fun onAdStarted(p0: AdStartedEvent?) {
 
    }

    override fun onAdTime(p0: AdTimeEvent?) {
 
    }

    override fun onAdViewableImpression(p0: AdViewableImpressionEvent?) {
 
    }

    override fun onAdWarning(p0: AdWarningEvent?) {
 
    }
    //endregion

    override fun onAudioTrackChanged(p0: AudioTrackChangedEvent?) {
 
    }

    override fun onAudioTracks(p0: AudioTracksEvent?) {
 
    }

    override fun onBeforeComplete(p0: BeforeCompleteEvent?) {
 
    }

    override fun onBeforePlay(p0: BeforePlayEvent?) {
 
    }

    override fun onBuffer(p0: BufferEvent?) {
    }

    override fun onBufferChange(p0: BufferChangeEvent?) {
        val values = mapOf(
            "percent" to (p0?.bufferPercent?.toDouble() ?: 0.0),
            "position" to (p0?.position ?: 0)
        )
        eventSink.success(mapOf("event" to "buffer", "values" to values))
    }

    override fun onCaptionsChanged(p0: CaptionsChangedEvent?) {
 
    }

    override fun onCaptionsList(p0: CaptionsListEvent?) {
 
    }

    override fun onComplete(p0: CompleteEvent?) {
 
    }

    override fun onControlBarVisibilityChanged(p0: ControlBarVisibilityEvent?) {
 
    }

    override fun onControls(p0: ControlsEvent?) {
 
    }

    override fun onDisplayClick(p0: DisplayClickEvent?) {
 
    }

    override fun onError(p0: ErrorEvent?) {
 
    }

    override fun onFirstFrame(p0: FirstFrameEvent?) {
 
    }

    override fun onFullscreen(p0: FullscreenEvent?) {
 
    }

    override fun onIdle(p0: IdleEvent?) {
 
    }

    override fun onLevels(p0: LevelsEvent?) {
 
    }

    override fun onLevelsChanged(p0: LevelsChangedEvent?) {
 
    }

    override fun onMeta(p0: EventMessageMetadataEvent?) {
 
    }

    override fun onMeta(p0: ExternalMetadataEvent?) {
 
    }

    override fun onMeta(p0: InPlaylistTimedMetadataEvent?) {
 
    }

    override fun onMeta(p0: MetaEvent?) {
 
    }

    override fun onMute(p0: MuteEvent?) {
 
    }

    override fun onPause(p0: PauseEvent?) {
        eventSink.success(mapOf("event" to "pause", "values" to mapOf<String, Any>()))
    }

    override fun onPipClose(p0: PipCloseEvent?) {
 
    }

    override fun onPipOpen(p0: PipOpenEvent?) {
 
    }

    override fun onPlay(p0: PlayEvent?) {
        eventSink.success(mapOf("event" to "play", "values" to mapOf<String, Any>()))
    }

    override fun onPlaybackRateChanged(p0: PlaybackRateChangedEvent?) {
 
    }

    override fun onPlaylist(p0: PlaylistEvent?) {
 
    }

    override fun onPlaylistComplete(p0: PlaylistCompleteEvent?) {
 
    }

    override fun onPlaylistItem(p0: PlaylistItemEvent?) {
 
    }

    override fun onReady(p0: ReadyEvent?) {
        eventSink.success(mapOf("event" to "isReady"))
    }

    override fun onRelatedClose(p0: RelatedCloseEvent?) {
 
    }

    override fun onRelatedOpen(p0: RelatedOpenEvent?) {
 
    }

    override fun onRelatedPlay(p0: RelatedPlayEvent?) {
 
    }

    override fun onSeek(p0: SeekEvent?) {
 
    }

    override fun onSeeked(p0: SeekedEvent?) {
 
    }

    override fun onSetupError(p0: SetupErrorEvent?) {
 
    }

    override fun onSharingClick(p0: SharingClickEvent?) {
 
    }

    override fun onSharingClose(p0: SharingCloseEvent?) {
 
    }

    override fun onSharingOpen(p0: SharingOpenEvent?) {
 
    }

    override fun onVisualQuality(p0: VisualQualityEvent?) {
 
    }

    override fun onVolume(p0: VolumeEvent?) {
 
    }

    override fun onWarning(p0: WarningEvent?) {
 
    }

    override fun onTime(p0: TimeEvent?) {
        val eventData = mapOf(
            "position" to (p0?.position ?: 0),
            "duration" to (p0?.duration ?: 0)
        )
        eventSink.success(mapOf("event" to "time", "values" to eventData))
    }
}

interface AllEventListeners:  AdvertisingEvents.OnAdBreakEndListener,
    AdvertisingEvents.OnAdBreakIgnoredListener,
    AdvertisingEvents.OnAdBreakStartListener,
    AdvertisingEvents.OnAdClickListener,
    AdvertisingEvents.OnAdCompanionsListener,
    AdvertisingEvents.OnAdCompleteListener,
    AdvertisingEvents.OnAdErrorListener,
    AdvertisingEvents.OnAdImpressionListener,
    AdvertisingEvents.OnAdMetaListener,
    AdvertisingEvents.OnAdPauseListener,
    AdvertisingEvents.OnAdPlayListener,
    AdvertisingEvents.OnAdRequestListener,
    AdvertisingEvents.OnAdScheduleListener,
    AdvertisingEvents.OnAdSkippedListener,
    AdvertisingEvents.OnAdStartedListener,
    AdvertisingEvents.OnAdTimeListener,
    AdvertisingEvents.OnAdViewableImpressionListener,
    AdvertisingEvents.OnAdWarningListener,
    AdvertisingEvents.OnBeforeCompleteListener,
    AdvertisingEvents.OnBeforePlayListener,
    PipPluginEvents.OnPipCloseListener,
    PipPluginEvents.OnPipOpenListener,
    RelatedPluginEvents.OnRelatedCloseListener,
    RelatedPluginEvents.OnRelatedOpenListener,
    RelatedPluginEvents.OnRelatedPlayListener,
    SharingPluginEvents.OnSharingClickListener,
    SharingPluginEvents.OnSharingCloseListener,
    SharingPluginEvents.OnSharingOpenListener,
    VideoPlayerEvents.OnAudioTrackChangedListener,
    VideoPlayerEvents.OnAudioTracksListener,
    VideoPlayerEvents.OnBufferChangeListener,
    VideoPlayerEvents.OnBufferListener,
    VideoPlayerEvents.OnCaptionsChangedListener,
    VideoPlayerEvents.OnCaptionsListListener,
    VideoPlayerEvents.OnCompleteListener,
    VideoPlayerEvents.OnControlBarVisibilityListener,
    VideoPlayerEvents.OnControlsListener,
    VideoPlayerEvents.OnDisplayClickListener,
    VideoPlayerEvents.OnErrorListener,
    VideoPlayerEvents.OnEventMessageMetadataListener,
    VideoPlayerEvents.OnExternalMetadataListener,
    VideoPlayerEvents.OnFirstFrameListener,
    VideoPlayerEvents.OnFullscreenListener,
    VideoPlayerEvents.OnIdleListener,
    VideoPlayerEvents.OnInPlaylistTimedMetadataListener,
    VideoPlayerEvents.OnLevelsChangedListener,
    VideoPlayerEvents.OnLevelsListener,
    VideoPlayerEvents.OnMetaListener,
    VideoPlayerEvents.OnMuteListener,
    VideoPlayerEvents.OnPauseListener,
    VideoPlayerEvents.OnPlayListener,
    VideoPlayerEvents.OnPlaybackRateChangedListener,
    VideoPlayerEvents.OnPlaylistCompleteListener,
    VideoPlayerEvents.OnPlaylistItemListener,
    VideoPlayerEvents.OnPlaylistListener,
    VideoPlayerEvents.OnReadyListener,
    VideoPlayerEvents.OnSeekListener,
    VideoPlayerEvents.OnSeekedListener,
    VideoPlayerEvents.OnSetupErrorListener,
    VideoPlayerEvents.OnVisualQualityListener,
    VideoPlayerEvents.OnVolumeListener,
    VideoPlayerEvents.OnWarningListener,
    VideoPlayerEvents.OnTimeListener {}

val AllEvents = arrayOf(
    AD_BREAK_END,
    AD_BREAK_START,
    AD_CLICK,
    AD_COMPANIONS,
    AD_COMPLETE,
    AD_ERROR,
    AD_IMPRESSION,
    AD_META,
    AD_PAUSE,
    AD_PLAY,
    AD_REQUEST,
    AD_SCHEDULE,
    AD_SKIPPED,
    AD_STARTED,
    AD_TIME,
    AD_WARNING,
    AUDIO_TRACKS,
    AUDIO_TRACK_CHANGED,
    BEFORE_COMPLETE,
    BEFORE_PLAY,
    BUFFER,
    BUFFER_CHANGE,
    CAPTIONS_CHANGED,
    CAPTIONS_LIST,
    COMPLETE,
    CONTROLBAR_VISIBILITY,
    CONTROLS,
    DISPLAY_CLICK,
    ERROR,
    EVENT_MESSAGE_METADATA,
    EXTERNAL_METADATA,
    FIRST_FRAME,
    FULLSCREEN,
    IDLE,
    IN_PLAYLIST_TIMED_METADATA,
    LEVELS,
    LEVELS_CHANGED,
    META,
    MUTE,
    PAUSE,
    PIP_CLOSE,
    PIP_OPEN,
    PLAY,
    PLAYBACK_RATE_CHANGED,
    PLAYLIST,
    PLAYLIST_COMPLETE,
    PLAYLIST_ITEM,
    READY,
    RELATED_CLOSE,
    RELATED_OPEN,
    RELATED_PLAY,
    SEEK,
    SEEKED,
    SETUP_ERROR,
    SHARING_CLICK,
    SHARING_CLOSE,
    SHARING_OPEN,
    TIME,
    VISUAL_QUALITY,
    VOLUME,
    WARNING
)