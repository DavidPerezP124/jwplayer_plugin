//
//  PlayerEventListener.swift
//  jwplayer
//
//  Created by David Perez on 06/11/22.
//

import JWPlayerKit
import Flutter

class PlayerViewController: JWPlayerViewController {
    private var eventSink: FlutterEventSink?
    
    func setEventSink(_ eventSink: FlutterEventSink? ) {
        self.eventSink = eventSink
    }
    
    override func jwplayerIsReady(_ player: JWPlayer) {
        super.jwplayerIsReady(player)
        eventSink?(["event": "isReady"])
    }
    
    override func onMediaTimeEvent(_ time: JWTimeData) {
        super.onMediaTimeEvent(time)
        let eventData = [
            "position": time.position,
            "duration": time.duration
        ]
        eventSink?(["event": "time", "values": eventData])
    }
    
    override func onAdTimeEvent(_ time: JWTimeData) {
        super.onAdTimeEvent(time)
        let eventData = [
            "position": time.position,
            "duration": time.duration
        ]
        eventSink?(["event": "adTime", "values": eventData])
    }
    
    override func jwplayer(_ player: AnyObject, adEvent event: JWAdEvent) {
        super.jwplayer(player, adEvent: event)
        // Get the ad event type. stringValue is an extension.
        let eventType = event.stringValue
        // Initialize with a client value
        var values: [String: Any] = ["client": event.client.description]
        switch event.type {
        case .adBreakEnd:
            if let position = event[.adPosition] as? JWAdPosition {
                values["position"] = position.stringValue
            }
        case .adBreakStart:
            if let position = event[.adPosition] as? JWAdPosition {
                values["position"] = position.stringValue
            }
        case .request:
            if let position = event[.adPosition] as? JWAdPosition {
                values["position"] = position.stringValue
            }
        default:
            break
        }
        
        eventSink?(["event": eventType, "values": values])
    }
    
    override func jwplayer(_ player: JWPlayer, updatedBuffer percent: Double, position time: JWTimeData) {
        super.jwplayer(player, updatedBuffer: percent, position: time)
        let values: [String : Any] = ["percent": percent, "position": time.position]
        eventSink?(["event": "buffer", "values": values])
    }
    
    override func jwplayer(_ player: JWPlayer, willPlayWithReason reason: JWPlayReason) {
        super.jwplayer(player, willPlayWithReason: reason)
        eventSink?(["event": "willPlay", "values": ["reason": reason.stringValue]])
    }
    
    override func jwplayer(_ player: JWPlayer, isPlayingWithReason reason: JWPlayReason) {
        super.jwplayer(player, isPlayingWithReason: reason)
        eventSink?(["event": "play", "values": ["reason": reason.stringValue]])
    }
    
    override func jwplayer(_ player: JWPlayer, isAttemptingToPlay playlistItem: JWPlayerItem, reason: JWPlayReason) {
        super.jwplayer(player, isAttemptingToPlay: playlistItem, reason: reason)
        eventSink?(["event": "playAttempt", "values": ["reason": reason.stringValue]])
    }

    override func jwplayer(_ player: JWPlayer, didPauseWithReason reason: JWPauseReason) {
        super.jwplayer(player, didPauseWithReason: reason)
        eventSink?(["event": "pause", "values": ["reason": reason.stringValue]])
    }
}
