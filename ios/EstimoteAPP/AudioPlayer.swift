//
//  AudioPlayer.swift
//  EstimoteAPP
//
//  Created by Mateusz on 30/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct AudioPlayer : View {
    @ObservedObject var audio = AudioLoader()
    @Binding var tracks:[TracksObjectModel]
    
    @State var play:Bool = false
    @State var opacity : Double = 1
    @State var height : CGFloat = 660
    @State var floating = false
    var trackIndex:Int = 0
    var audioUrl:String = ""
    
    var body : some View{
        
        GeometryReader{geo in
            VStack{
                
                ForEach(self.tracks){x in
                    HStack{
                        
                        Image("music").resizable().frame(width: 45, height: 45).cornerRadius(10)
                        
                        VStack(alignment : .leading){
                            
                            Text(x.title).fontWeight(.heavy)
                                .onTapGesture{
                                    self.audio.setTrack(urlString:x.url)
                                    playTrack()
                                }
                        }
                        
                        Spacer()
                        
                        if(x.id == self.tracks.first?.id){
                            Image(systemName: self.play ? "pause.fill" : "play.fill")
                                .resizable().frame(width: 20, height: 20)
                                .onTapGesture{
                                    self.audio.setTrack(urlString:self.tracks[self.trackIndex].url)
                                    playOrPause()
                                }.foregroundColor(.white)
                        }
                        
                    }.padding(10)
                }
                
                Spacer()
                
                
            }.opacity(self.opacity)
            .background(Color(red: 143/255, green: 203/255, blue: 235/255, opacity: 0.9))
            .offset(y: self.height)
            
            .animation(.spring())
            .gesture(DragGesture()
                        
                        .onChanged({ (value) in
                            
                            if self.height >= 0{
                                
                                self.height += value.translation.height / 8
                                self.opacity = 0.5
                            }
                            
                        })
                        .onEnded({ (value) in
                            
                            if self.height > 100 && !self.floating{
                                
                                self.height = geo.size.height - 60
                                self.opacity = 1
                                self.floating = true
                                
                            }
                            else{
                                
                                if self.height < geo.size.height - 150{
                                    
                                    self.height = 200
                                    self.opacity = 1
                                    self.floating = false
                                }
                                else{
                                    
                                    self.height = geo.size.height - 60
                                    self.opacity = 1
                                }
                            }
                        }))
        }
        
    }
    
    func playTrack(){
        self.play = true
        self.height = 660
        self.audio.playTrack()
    }
    
    func playOrPause(){
        self.play = !self.play
        
        self.audio.togglePlayTrack()
        
    }
}

