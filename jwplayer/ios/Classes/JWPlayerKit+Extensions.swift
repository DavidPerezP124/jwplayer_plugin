//
//  JWPlayerKit+Extensions.swift
//  jwplayer
//
//  Created by David Perez on 08/11/22.
//

import JWPlayerKit

extension JWAdEvent {
    var stringValue: String {
        switch self.type {
        case .adBreakEnd:
            return "adBreakEnd"
        case .adBreakStart:
            return "adBreakStart"
        case .clicked:
            return "adClicked"
        case .complete:
            return "adComplete"
        case .impression:
            return "adImpression"
        case .meta:
            return "adMeta"
        case .pause:
            return "adPause"
        case .play:
            return "adPlay"
        case .request:
            return "adRequest"
        case .schedule:
            return "adSchedule"
        case .skipped:
            return "adSkipped"
        case .started:
            return "adStarted"
        case .companion:
            return "adCompanion"
        @unknown default:
            return "unknown"
        }
    }
}

extension JWAdPosition {
    var stringValue: String {
        switch self {
        case .pre:
            return "pre"
        case .mid:
            return "mid"
        case .post:
            return "post"
        case .unknown:
            return "unknown"
        @unknown default:
            return "unknown"
        }
    }
}

extension JWPlayReason {
    var stringValue: String {
        switch self {
        case .autostart:
            return "autostart"
        case .external:
            return "external"
        case .interaction:
            return "interaction"
        case .playlist:
            return "playlist"
        case .viewable:
            return "viewable"
        case .repeatContent:
            return "repeatContent"
        case .relatedInteraction:
            return "relatedInteraction"
        case .relatedAuto:
            return "relatedAuto"
        case .settingsInteraction:
            return "settingsInteraction"
        case .unknown:
            return "unknown"
        @unknown default:
            return "unknown"
        }
    }
}

extension JWPauseReason {
    var stringValue: String {
        switch self {
        case .external:
            return "external"
        case .interaction:
            return "interaction"
        case .viewable:
            return "viewable"
        case .relatedInteraction:
            return "relatedInteraction"
        case .settingsInteraction:
            return "settingsInteraction"
        case .unknown:
            return "unknown"
        case .clickthrough:
            return "clickthrough"
        @unknown default:
            return "unknown"
        }
    }
}
