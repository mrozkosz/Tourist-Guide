//
//  ContentView.swift
//  Estimote
//
//  Created by Mateusz on 17/04/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import SwiftUI
import EstimoteProximitySDK

struct Content: Identifiable {
    var id: String
    let title: String
    let subtitle: String
}

class BeaconDetector:NSObject,ObservableObject{
    @Published var proximityObserver: ProximityObserver!
    @Published var nearbyContent = [Content]()
    @Published var estimoteCloudCredentials:CloudCredentials!
    @Published var zone:ProximityZone!
    override init(){
        super.init()
        self.estimoteCloudCredentials = CloudCredentials(appID: "mateuszrozkosz97-gmail-com-72t", appToken: "6a801bf31ca12adff113be06414b9e2d")
        
        self.proximityObserver = ProximityObserver(credentials: estimoteCloudCredentials, onError: { error in
            print("ProximityObserver error: \(error)")
        })
        
        self.zone = ProximityZone(tag: "mateuszrozkosz97-gmail-com-72t", range: ProximityRange(desiredMeanTriggerDistance: 0.5)!)
        
        self.zone.onContextChange = { contexts in
            
            for i in contexts {
                let id = i.deviceIdentifier
                let title = i.attachments["mateuszrozkosz97-gmail-com-72t/title"]
                self.nearbyContent.append(Content(id: id, title:title ?? "null", subtitle: id))
            }
        }
        
        self.zone.onExit = { zoneContext in
            print("Exited \(zoneContext.deviceIdentifier)")
            self.nearbyContent.removeAll()
        }
        proximityObserver.startObserving([self.zone])
    }
}

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
