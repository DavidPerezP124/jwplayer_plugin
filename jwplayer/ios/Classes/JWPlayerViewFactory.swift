//
//  JWPlayerFactory.swift
//  Runner
//
//  Created by David Perez on 05/08/22.
//
import JWPlayerKit
import Flutter
import Foundation

private let vmapUrlString = "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&output=vmap&unviewed_position_start=1&cust_params=deployment%3Ddevsite%26sample_ar%3Dpremidpost&cmsid=496&vid=short_onecue&correlator="

fileprivate enum Methods: String {
    case create
    case pause
    case stop
    case play
    case setConfig
}

class JWPlayerFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    var views: [Int64:PlayerInterface]? = [:]
    var lastView: Int64 = 0
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        let channel = FlutterMethodChannel(name: "playerview", binaryMessenger: messenger)
        super.init()
        channel.setMethodCallHandler(self.handle)
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let nativeView = JWNativeView()
        views?[viewId] = nativeView
        lastView += 1

        let view = nativeView.view()
        view.frame =  frame
        return nativeView
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = Methods.init(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        switch method {
        case .create:
            result(lastView)
        case .play:
            views?.forEach({ (key: Int64, value: PlayerInterface) in
                value.play()
            })
        case .setConfig:
            let arguments = call.arguments as! [String: Any]
            let config = arguments["config"] as! [String: Any]
            let id = arguments["id"] as! Int64
            do {
                let config = try ConfigTransfomer(tranformable: config).toJWConfig()
                views?[id]?.setConfig(config: config)
            } catch {
                print(error.localizedDescription)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

class JWNativeView: NSObject, FlutterPlatformView, PlayerInterface {
    let controller = JWPlayerViewController()
    
    func view() -> UIView {
        return controller.view
    }
    
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

protocol PlayerInterface: AnyObject {
    func setConfig(config: JWPlayerConfiguration)
    func play()
    func pause()
    func stop()
}
