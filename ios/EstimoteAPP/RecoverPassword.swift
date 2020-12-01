//
//  RecoverPassword.swift
//  EstimoteAPP
//
//  Created by Mateusz on 23/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct RecoverPassword: View {
    @Binding var showSheetView: Bool
    @State var email:String = ""
    @State var network = AuthService()
    @State var hash:String = ""
    @State var password:String = ""
    @State var showPassword:Bool = false
    @State var isRecoverPasswordSend:Bool = false
    @State var errorMessage:[String] = []
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Zresetuj hasło")
                    .font(.title)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Wprowadź swój adres email, aby poprosić o zresetowanie hasła")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if(self.isRecoverPasswordSend ){
                    OtherTextField(icon: "lock", placeholder: "Kod", text: self.$hash)
                    PasswordTextField(showPassword: self.showPassword, password: self.$password).padding(.top,5)
                    
                }else{
                    OtherTextField(icon: "person", placeholder: "Email", text: self.$email).padding(.top,5)
                }
                
                HStack{
                    if(self.errorMessage.count>0){
                        Text("\(self.errorMessage[0])")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }.padding(.top,5).padding(.bottom,-5)
                
                HStack(alignment: .center){
                    
                    Button(action: {
                        self.recoverPasswordButtonAction()
                    }, label: {
                        Text("Wyślij")
                            .padding(10)
                            .foregroundColor(Color.white)
                            .frame(width: 300, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 0)
                                    .background(Color(red: 0.36, green: 0.42, blue: 0.87).cornerRadius(10))
                        )
                        
                    })
                    
                }.offset(y:20)
                
                HStack(alignment: .center){
                    if(!self.isRecoverPasswordSend){
                        Button(action: {
                            self.isRecoverPasswordSend = true
                        }, label: {
                            Text("Mam już kod")
                                .padding(10)
                        })
                    }
                }.offset(y:20)
                Spacer()
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            ).padding()
                .background(Color("MainColor"))
                .cornerRadius(25)
                .offset(y:-90)
        }
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func recoverPasswordButtonAction(){
        self.hideKeyboard()
        if(!self.isRecoverPasswordSend){
            self.network.recoverPassword(email: self.email)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.errorMessage = self.network.errorMessage
                self.isRecoverPasswordSend = self.network.isRecoverPasswordSend
            }
        }else{
            self.network.setNewPassword(hash: self.hash, password: self.password)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.errorMessage = self.network.errorMessage
                
                if(self.network.passwordHasBeenChanged){
                    self.showSheetView = false
                }
            }
        }
    }
}

struct RecoverPassword_Previews: PreviewProvider {
    static let network = AuthService()
    
    static var previews: some View {
        RecoverPassword(showSheetView: .constant(true), network: network)
    }
}
