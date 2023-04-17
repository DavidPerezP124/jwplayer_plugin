package jwplayer.jwplayer

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink


final class QueueEventSink: EventChannel.EventSink  {
    /// The underlying event sink
    private var mDelegate: EventSink? = null
    private var eventQueue: ArrayList<Any> = ArrayList()
    private var done = false

    /// Adds an event sink as listener.
    fun setListener(delegate: EventSink?) {
        mDelegate = delegate
        tryFlush()
    }

    private fun enqueue(event: Any) {
        if (done) {
            return
        }
        eventQueue.add(event)
        tryFlush()
    }

    /**
    * Will try to flush the existing event queue.
    * This should be called whenever we enqueue or receive an event
    */
    private fun tryFlush() {
        if (mDelegate == null) return

        for (event in eventQueue) {
            when (event) {
                (event is EndOfStreamEvent) -> {
                    mDelegate?.endOfStream()
                }
                (event is ErrorEvent) -> {
                    val errorEvent = event as ErrorEvent
                    mDelegate?.error(errorEvent.code, errorEvent.message, errorEvent.details)
                }
                else -> mDelegate?.success(event)
            }
        }
        eventQueue.clear()
    }

    /**
     *  A signal for stream ending
     */
    private class EndOfStreamEvent

    /// An internal class to wrap the error received by EventSink super class
    private class ErrorEvent internal constructor(
        var code: String?,
        var message: String?,
        var details: Any?
    )

    // MARK:

    //region EventSink
    override fun success(event: Any?) {
        if (event == null) return
        enqueue(event);
    }

    override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
        enqueue( ErrorEvent(errorCode, errorMessage, errorDetails))
    }

    override fun endOfStream() {
        enqueue(EndOfStreamEvent())
        done = true
    }
    //endregion
}
