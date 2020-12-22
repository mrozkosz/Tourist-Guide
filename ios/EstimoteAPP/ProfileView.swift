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
                
                Text("wyloguj się").onTapGesture {
                    self.logout()
                }
                

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
