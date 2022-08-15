//
//  JWPlayerFactory.swift
//  Runner
//
//  Created by David Perez on 05/08/22.
//
import JWPlayerKit
import Flutter
import Foundation

class JWPlayerFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let nativeView = JWNativeView()
        let view = nativeView.view()
        view.frame =  frame
        return nativeView
    }
}

class JWNativeView: NSObject, FlutterPlatformView {
    let controller = JWPlayerViewController()
    
    func view() -> UIView {
        let playlistItem = try! JWPlayerItemBuilder().file(URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!).build()
        let config = try! JWPlayerConfigurationBuilder().playlist([playlistItem]).build()
        controller.player.configurePlayer(with: config)
        return controller.view
    }
}
