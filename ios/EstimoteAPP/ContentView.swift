//
//  ContentView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI


let items: [BottomBarItem] = [
    BottomBarItem(icon: "house.fill", title: "", color: .purple),
    BottomBarItem(icon: "heart", title: "", color: .pink),
    BottomBarItem(icon: "magnifyingglass", title: "", color: .orange),
    BottomBarItem(icon: "person.fill", title: "", color: .green),
    BottomBarItem(icon: "person.fill", title: "", color: .blue)
]

struct ContentView : View {
    @ObservedObject var network = AuthService()
    @State private var storage = LocalStorage()
    @State private var selectedIndex: Int = 0
    
    
    init() {
        self.checkIsLogged()
    }
    
    @ViewBuilder
    var body: some View {
        
        if #available(iOS 14.0, *) {
            
            if(self.network.isLoggedUser){
                mainMenu(network:network, selectedIndex:$selectedIndex)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }else{
                Login(network: network)
            }
            
        } else {
            
            if(self.network.isLoggedUser){
                mainMenu(network:network, selectedIndex:$selectedIndex)
            }else{
                Login(network: network)
            }
            
        }
        
    }
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    func checkIsLogged(){
        if(self.storage.refreshToken != ""){
            self.network.refreshToken(refreshToken: self.storage.refreshToken)
        }else{
            self.network.isLoggedUser = false
        }
    }
}

struct mainMenu: View {
    @State var network:AuthService
    @Binding var selectedIndex:Int
    
    var body: some View {
        VStack{
            
            if(self.selectedIndex == 0) {
                
                HomePageList()
            }
            
            if(self.selectedIndex == 1) {
                
                Text("Page 4")
            }
            
            if(self.selectedIndex == 2) {
                
                SearchPage()
            }
            
            if(self.selectedIndex == 3) {
                
                
            }
            
            if(self.selectedIndex == 4) {
                
                
            }
            
            if(self.selectedIndex == 5) {
                
                SinglePleace(id: 1)
            }
            
            
            Spacer()
            
            ZStack{
                BottomBar(selectedIndex: self.$selectedIndex, items: items).scaleEffect(0.8)
            }
            
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
