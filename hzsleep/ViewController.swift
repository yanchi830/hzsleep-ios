//
//  ViewController.swift
//  hzsleep
//
//  Created by Chi Yan on 1/31/20.
//  Copyright © 2020 Chi Yan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    private var player:AVQueuePlayer?
    private var playerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        super.view.backgroundColor = UIColor.lightGray
        let mediaPath = URL(fileURLWithPath: Bundle.main.path(forResource: "sample", ofType: "mp3")!)

        startMedia(mediaUrl: mediaPath)
    }

    public func startMedia(mediaUrl: URL) {
        player = AVQueuePlayer()
        playerLayer = AVPlayerLayer(player: player)
        
        guard let playerLayer = playerLayer else { fatalError("Error creating player layer") }
        playerLayer.frame = view.layer.bounds
        view.layer.addSublayer(playerLayer)
        
        let mediaAsset = AVURLAsset(url: mediaUrl)
        mediaAsset.loadValuesAsynchronously(forKeys: ["duration", "playable"]) {
            DispatchQueue.main.async {
                let loopItem = AVPlayerItem(asset: mediaAsset)
                self.player?.insert(loopItem, after: nil)
                
                self.player?.play()
            }
        }
    }
}
