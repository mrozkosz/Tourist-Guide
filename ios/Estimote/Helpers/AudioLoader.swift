//
//  AudioLoader.swift
//  Estimote
//
//  Created by Mateusz on 22/06/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import AVFoundation
import AVKit


class AudioLoader {
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var urlString: String?
    
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    func loadAudio() {
        let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        player!.play()
    }
    
    
}
