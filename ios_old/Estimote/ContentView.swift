//
//  ContentView.swift
//  Estimote
//
//  Created by Mateusz on 17/04/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import SwiftUI
import EstimoteProximitySDK


struct Home: View {
    @ObservedObject var detector = BeaconDetector()
    var body: some View{
        VStack{
            List(detector.nearbyContent){ i in
                Text(i.title)
            }
        }
    }
}
struct BottomTapBar: View {
    @Binding var index: Int
    var body: some View{
        HStack{
            
            Button(action: {
    
                self.index = 0
            }){
                Image("home-icon")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.black)
                    .opacity(self.index == 0 ?1.0: 0.5)
                Text(String(self.index))
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 1
            }){Image("home-icon")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.black)
                .opacity(self.index == 1 ?1.0: 0.5)
            }
            
            Spacer(minLength: 0)
            Button(action: {
                self.index = 2
            }){Image("home-icon")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.black)
                .opacity(self.index == 2 ?1.0: 0.5)
            }
            Spacer(minLength: 0)
            Button(action: {
                self.index = 3
            }){Image("home-icon")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.black)
                .opacity(self.index == 3 ?1.0: 0.5)
            }
            
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 15)
        
    }
}
struct ContentView: View {
    @State var index = 0
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            if self.index == 0{
                Home()
            }
            Spacer()
//            BottomTapBar(index: self.$index)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
