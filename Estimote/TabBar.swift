//
//  TabBar.swift
//  Estimote
//
//  Created by Mateusz on 25/05/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct TabBar: View {

    var body: some View {
        TabView{
            HomePage().tabItem{
                Image("search")
                 .resizable()
                .clipped()
                Text("Szukaj")
            }
            ContentView().tabItem{
                Image("radar")
                Text("Radar")
            }
            Radar().tabItem{
                Image("heart_dark")
                Text("Ulubione")
            }
            HomePage().tabItem{
                Image("user")
                Text("Profil")
            }
        }.onAppear{
            UITabBar.appearance().backgroundColor = UIColor(named: "app-white")
        }.accentColor(.gray)
        
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().previewDevice("iPhone 8")
    }
}

