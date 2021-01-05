//
//  ProfileView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 09/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var settings:Settings
    @ObservedObject var authVM:AuthViewModel
    @ObservedObject var  locationMonitoringStatus = LocationMonitoring()
    @ObservedObject var network = NetworkMonitoring.shared
    
    
    var storage = LocalStorage()
    
    var body: some View {
        ZStack{
            Background()
            
            VStack(alignment: .leading){
                Text("\(self.authVM.firstName) \(self.authVM.lastName)").padding(.leading, 20).padding(.top, 25)
                    .font(.title)
                    .foregroundColor(Color.gray)
                
                Text(self.authVM.email).padding(.leading, 20)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                
                
                HStack{
                    Text("LogOut")
                        .foregroundColor(Color.orange)
                        .onTapGesture {
                        self.logout()
                    }.frame(width:70, height:20)
                    .padding(12)
                    .background(
                        Capsule()
                            .fill(Color.orange.opacity(0.2)))
                    
                    
                    if(locationMonitoringStatus.isEnabled){
                        Icons(isEnabled: true, icon: "location.fill", color: .green)
                    }else{
                        Icons(isEnabled: false, icon: "location.slash.fill", color: .green)
                    }
                    
                    if(network.isConnected){
                        Icons(isEnabled: true, icon: "wifi", color: .blue)
                    }else{
                        Icons(isEnabled: false, icon: "wifi.slash", color: .blue)
                    }
                    
                }.padding()
                
                
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(Color("MainColor"))
            .cornerRadius(25)
            .offset(y:100)
            
        }.edgesIgnoringSafeArea(.all)
        .onAppear{
            self.authVM.me()
        }
    }
    func logout(){
        storage.token = ""
        storage.refreshToken = ""
        storage.email = ""
        self.authVM.isLoggedUser = false
        self.settings.selectedPage = 0
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authVM: AuthViewModel())
    }
}




public struct Icons: View {
    var isEnabled: Bool
    @State var icon:String
    @State var color:Color
    
    
    public var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width:20, height:20)
                .imageScale(.large)
                .foregroundColor(isEnabled ? color : .white)
        }
        .padding(12)
        .background(
            Capsule()
                .fill(isEnabled ?
                        color.opacity(0.2) : Color.gray))
        .padding(.bottom, 3)
    }
}

//struct Icons_Previews: PreviewProvider {
//    static var previews: some View {
//        Icons(isEnabled: true, icon: "wifi", color: .blue)
//    }
//}


