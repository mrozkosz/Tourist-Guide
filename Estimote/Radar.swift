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
    @State var showBottomCard = true
    @State var viewState = CGSize.zero
    @ObservedObject var detector = BeaconDetector()
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 5.0)
            .repeatForever(autoreverses: false)
    }
    var body: some View {
        ZStack{
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
                        .onAppear {self.isAnimating = true}
                        .onDisappear {self.isAnimating = false}
                    Image("line")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0), anchor: .center)
                        .animation(Animation.linear(duration: 5.0)
                        .repeatForever(autoreverses: false))
                        .onAppear {self.isAnimating = true}
                        .onDisappear {self.isAnimating = false}
                }
                Text("Radar")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Szukam ciekawych miejsc w okolicy")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }.blur(radius: isVisible(beacons: detector) ?18:0)
            BottomCard(beacons: detector)
            .offset(x:0,y: isVisible(beacons: detector) ?400:1000)
        }
        .onAppear {
            self.isAnimating = true
        }
    }
    func isVisible(beacons:BeaconDetector) -> Bool {
        let count = beacons.nearbyContent.count
        if(count == 0){
            return false
        }
            return true
        
    }
}


struct Radar_Previews: PreviewProvider {
    static var previews: some View {
        Radar()
    }
}

struct BottomCard: View {
    @ObservedObject var beacons:BeaconDetector
    var body: some View {
        VStack{
            Rectangle()
                .frame(width: 40, height:5)
                .cornerRadius(3)
                .opacity(0.1)
            HStack() {
                Text("Wyniki wyszukiwania")
                    .font(.system(size: 22))
                    .bold()
                Spacer()
            }
            
            HStack() {
                Text("znaleziono \(beacons.nearbyContent.count) pozycje")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            VStack{
                List(beacons.nearbyContent){ i in
                    Text(i.title)
                }
            }
            Spacer()
        }
            
        .frame(maxWidth:325)
        .padding()
        .background(RoundedCorners(tl: 30, tr: 30, bl: 0, br: 0).fill(Color("app-white")))
        .clipped()
        .shadow(radius: 20)
    }
}
