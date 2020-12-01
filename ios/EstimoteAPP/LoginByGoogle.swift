//
//  LoginByGoogle.swift
//  EstimoteAPP
//
//  Created by Mateusz on 23/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct LoginByGoogle: View {
     @State var network:AuthService
    
    var body: some View {
        Button(action: {}) {
            Image("google")
                .resizable()
                .frame(width:35, height: 35)
            
        }.buttonStyle(PlainButtonStyle())
    }
}

struct LoginByGoogle_Previews: PreviewProvider {
    static let network = AuthService()
    
    static var previews: some View {
        LoginByGoogle(network: network)
    }
}
