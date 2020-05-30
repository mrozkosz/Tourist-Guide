//
//  Radar.swift
//  Estimote
//
//  Created by Mateusz on 25/05/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct Radar: View {
    @State var angle: Double = 0.0
    @State var isAnimating = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 5.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        
        VStack{
            
            ZStack(alignment: .bottomTrailing){
                Image("radar_bg")
                    .resizable()
                    .frame(width: 250, height: 250)
                Image("radar_blue")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0), anchor: .center)
                    .animation(Animation.linear(duration: 5.0)
                        .repeatForever(autoreverses: false))
                    .onAppear {
                        self.isAnimating = true
                }
                .onDisappear {
                    self.isAnimating = false
                }
                
                
            }
        }
        .onAppear {
            self.isAnimating = true
        }
        
        
        
    }
}


struct Radar_Previews: PreviewProvider {
    static var previews: some View {
        Radar()
    }
}
