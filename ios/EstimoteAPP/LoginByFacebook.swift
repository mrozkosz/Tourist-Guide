//
//  LoginByFacebook.swift
//  EstimoteAPP
//
//  Created by Mateusz on 23/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit

struct LoginByFacebook: View {
    @State var network:AuthViewModel
    @State var loginManager = LoginManager()
    @State var facebookToken:String = ""
    
    var body: some View {
        
        Button(action: {
            self.loginManager.logIn(permissions: ["public_profile","email"], from: nil){
                (result, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                
                let request = GraphRequest(graphPath:"me", parameters: ["fields":"email"])
                
                self.facebookToken = request.tokenString ?? "null"
                
                self.network.loginByFacebook(FBtoken: request.tokenString ?? "null")
                
            }
            
        }) {
           
            
            Text("Join via Facebook")
                .foregroundColor(Color.white)
                .frame(width: 300, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0)
                        .background(Color(red: 59/255, green: 89/255, blue: 152/255).cornerRadius(10))
              
                )
                .overlay(
                    HStack{
                    Image("facebook")
                        .resizable()
                        .frame(width:35, height: 35)
                        .padding(.leading, 5)
                    Spacer()
                    }
                )
            
        }.buttonStyle(PlainButtonStyle())
        
        
    }
}

struct LoginByFacebook_Previews: PreviewProvider {
    static let network = AuthViewModel()
    
    static var previews: some View {
        LoginByFacebook(network: network)
    }
}
