//
//  AudioLoader.swift
//  EstimoteAPP
//
//  Created by Mateusz on 10/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import AVFoundation
import AVKit


class AudioLoader: ObservableObject{
    @Published var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var urlsArray = [TracksObjectModel]()
    var urlString: String = "https://s3.amazonaws.com/kargopolov/kukushka.mp3"
    var position:Int = 0
    
    var play:Bool = false
    var isLoaded:Bool = false
    
  
    
    func setTracks(urlsArray: [TracksObjectModel]){
        self.urlsArray = urlsArray

        getFirstTrack()
    }
    
    func setTrack(urlString: String){
        self.urlString = baseUrl + "/tracks/" + urlString
    }
    
    func getFirstTrack(){
        let count = self.urlsArray.count
        
        
        if((count) != 0){
            self.urlString = (self.urlsArray.first!.url)
        }
        
    }
    
    func backTrack(){
        
        if(self.position - 1 >= 0){
            self.position = (self.urlsArray.index(before: self.position))
            self.urlString = (self.urlsArray[self.position].url)
        }
    }
    
    func nextTrack(){
        let count = self.urlsArray.count
        
        if(count-1 > self.position){
            self.position = (self.urlsArray.index(after: self.position))
            self.urlString = self.urlsArray[self.position].url
        }
    }
    
    func loadAudio() {
        
        let url = URL(string: self.urlString)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player!.automaticallyWaitsToMinimizeStalling = false
        
    }
    
    func togglePlayTrack(){
        if(!self.isLoaded){
            self.loadAudio()
        }
        
        if(self.play){
            self.player!.pause()
            self.play = false
        }else{
            self.player!.play()
            self.play = true
        }
    }
    
    func playTrack(){
        if(!self.isLoaded){
            self.loadAudio()
        }
        
        if(!self.play){
            self.player!.play()
            self.play = false
        }
    }
}
