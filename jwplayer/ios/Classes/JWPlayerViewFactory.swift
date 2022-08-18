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
        let adConfig = try! JWImaAdvertisingConfigBuilder()
            // Set the VMAP url for the builder to use.
            .vmapURL(URL(string: vmapUrlString)!)
            .build()
        
        let config = try! JWPlayerConfigurationBuilder().playlist([playlistItem])
            .advertising(adConfig)
            .build()
        controller.player.configurePlayer(with: config)
        return controller.view
    }
}
