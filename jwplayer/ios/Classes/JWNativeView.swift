
import JWPlayerKit
import Flutter

protocol PlayerInterface: AnyObject {
    var eventSink: FlutterEventSink? { get set }
    func setConfig(config: JWPlayerConfiguration)
    func play()
    func pause()
    func stop()
}


class JWNativeView: NSObject, FlutterPlatformView, PlayerInterface {
    
    private let controller = PlayerViewController()
    
    var eventSink: FlutterEventSink? {
        didSet {
            controller.setEventSink(eventSink)
        }
    }
    
    func view() -> UIView {
        return controller.view
    }
    
    // MARK: - Player API
    
    func setConfig(config: JWPlayerConfiguration) {
        controller.player.configurePlayer(with: config)
    }
    
    func play() {
        controller.player.play()
    }
    
    func pause() {
        controller.player.pause()
    }
    
    func stop() {
        controller.player.stop()
    }
}
