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
    @State var network:AuthService
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
                
                self.network.loginByFacebook(token: request.tokenString ?? "null")
                
            }
            
        }) {
            Image("facebook")
                .resizable()
                .frame(width:35, height: 35)
            
        }.buttonStyle(PlainButtonStyle())
        
        
    }
}

struct LoginByFacebook_Previews: PreviewProvider {
    static let network = AuthService()
    
    static var previews: some View {
        LoginByFacebook(network: network)
    }
}
