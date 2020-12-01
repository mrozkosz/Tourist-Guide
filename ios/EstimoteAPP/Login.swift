//
//  FacebookLogin.swift
//  EstimoteAPP
//
//  Created by Mateusz on 14/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
//import Foundation
//import Combine

struct Login: View {
    var network:AuthService
    @State var showPassword:Bool = false
    @State var email:String = ""
    @State var password:String = ""
    @State var showSheetView = false
    @State var errorMessage:[String] = []
    
    init(network: AuthService) {
        self.network = network
    }
    
    var body: some View {
        ZStack{
            Background()
            
            VStack(alignment: .leading){
                Text("Zaloguj się").padding(.leading, 20).padding(.top, 25)
                    .font(.title)
                    .foregroundColor(Color.gray)
                
                Text("Witaj ponownie!").padding(.leading, 20)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                
                VStack {
                    OtherTextField(icon: "person", placeholder: "Email", text: self.$email)
                    PasswordTextField(showPassword: self.showPassword, password: self.$password).padding(.top,5)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            self.showSheetView.toggle()
                        }) {
                            Text("Przypomnij Hasło")
                        }.sheet(isPresented: $showSheetView) {
                            RecoverPassword(showSheetView: self.$showSheetView)
                        }
                        
                    }.padding(.top,10)
                    
                    HStack{
                        if(self.errorMessage.count > 0){
                            Text("\(self.errorMessage[0])")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    HStack(alignment: .center){
                        Button(action: {
                            self.network.login(email: self.email, password: self.password)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.errorMessage = self.network.errorMessage
                            }
                            
                        }, label: {
                            Text("Zaloguj się")
                                .padding(10)
                                .foregroundColor(Color.white)
                                .frame(width: 300, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 0)
                                        .background(Color(red: 0.36, green: 0.42, blue: 0.87).cornerRadius(10))
                            )
                            
                        })
                        
                    }.offset(y:10)
                    
                    HStack{
                        Image("wave")
                            .resizable()
                            .scaledToFill()
                            .frame(width:110, height: 10)
                            .padding(.top,30)
                            .padding(.bottom, 10)
                    }
                    
                    HStack{
                        LoginByFacebook(network: self.network)
                        LoginByGoogle(network: self.network)
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
    }
}


struct FacebookLogin_Previews: PreviewProvider {
    static let network = AuthService()
    
    static var previews: some View {
        Login(network: network)
    }
}



struct PasswordTextField: View {
    @State var showPassword:Bool
    @Binding var password:String
    
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.secondary)
                .padding(.leading,10)
            if self.showPassword {
                TextField("Password",
                          text: self.$password).padding([.top,.bottom],10)
                    .autocapitalization(.none)
                    .padding(.leading,5)
            } else {
                SecureField("Password",
                            text: self.$password).padding([.top,.bottom],10)
                    .autocapitalization(.none)
                    .padding(.leading,5)
            }
            
            Button(action: {
                self.hideKeyboard()
                self.showPassword.toggle()}) {
                    Image(systemName: "eye")
                        .foregroundColor(.secondary)
            }.padding(.horizontal,15)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray,lineWidth: 0.9)
        )
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct OtherTextField: View {
    @State var icon:String
    @State var placeholder:String
    @Binding var text:String
    
    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .foregroundColor(.secondary)
                .padding(.leading,10)
            TextField(self.placeholder,
                      text: self.$text).padding([.top,.bottom],10)
                .autocapitalization(.none)
                .padding(.leading,5)
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray,lineWidth: 0.9)
        )
    }
}

struct Background: View {
    var body: some View {
        VStack{
            
            HStack{
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:45, height: 45)
                
                Text("wirayasa.design")
                    .foregroundColor(.white)
            }.padding().padding(.top,15)
            
            Spacer()
            
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
        )
            .background(Color("DarkBlue"))
    }
}
