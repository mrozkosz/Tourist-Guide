//
//  ContentView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

let items: [BottomBarItem] = [
    BottomBarItem(icon: "house.fill", color: .purple),
    BottomBarItem(icon: "heart", color: .pink),
    BottomBarItem(icon: "magnifyingglass", color: .orange),
    BottomBarItem(icon: "map", color: .green),
    BottomBarItem(icon: "person.fill", color: .blue)
]

struct ContentView : View {
    @ObservedObject var network = AuthViewModel()
    @State private var storage = LocalStorage()
    @EnvironmentObject var settings:Settings
    
    init() {
        self.network.isLogged()
    }
    
    @ViewBuilder
    var body: some View {
        
        if #available(iOS 14.0, *) {
            
            if(self.network.isLoggedUser){
                mainMenu( authVM: network, selectedIndex:$settings.selectedPage)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }else{
                beforeLogin(authVM: network, selectedIndex:$settings.selectedPage)
            }
            
        } else {
            
            if(self.network.isLoggedUser){
                mainMenu( authVM: network, selectedIndex:$settings.selectedPage)
            }else{
                
                beforeLogin(authVM: network, selectedIndex:$settings.selectedPage)
            }
            
        }
        
    }
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}


struct beforeLogin: View {
    @ObservedObject var authVM:AuthViewModel
    @Binding var selectedIndex:Int
    
    
    var body: some View {
        VStack{
            
            if(self.selectedIndex == 0) {
                
                Login(authVM: authVM)
            }
            
            if(self.selectedIndex == 1) {
                
                SignUp(authVM: authVM)
            }
        }
    }
}


struct mainMenu: View {
    @ObservedObject var authVM:AuthViewModel
    @Binding var selectedIndex:Int
    
    
    var body: some View {
        VStack{
            
            if(self.selectedIndex == 0) {
                
                HomePageList()
            }
            
            if(self.selectedIndex == 1) {
                
                FavoritesView()
            }
            
            if(self.selectedIndex == 2) {
                
                SearchPage()
            }
            
            if(self.selectedIndex == 3) {
                MapView()
                
            }
            
            if(self.selectedIndex == 4){
                
                ProfileView(authVM: authVM)
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
