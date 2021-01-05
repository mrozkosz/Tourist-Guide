//
//  signUp.swift
//  EstimoteAPP
//
//  Created by Mateusz on 10/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var settings:Settings
    @ObservedObject var authVM:AuthViewModel
    @State var showPassword:Bool = false
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var email:String = ""
    @State var password:String = ""
    
    
    var body: some View {
        ZStack{
            Background()
            
            VStack(alignment: .leading){
                Text("Zapisz się").padding(.leading, 20).padding(.top, 25)
                    .font(.title)
                    .foregroundColor(Color.gray)
                
                Text("You're close!").padding(.leading, 20)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                
                VStack {
                    OtherTextField(icon: "person", placeholder: "First Name", text: self.$firstName).padding(.bottom, 5 )
                    OtherTextField(icon: "person", placeholder: "Last Name", text: self.$lastName).padding(.bottom, 5 )
                    OtherTextField(icon: "person", placeholder: "Email", text: self.$email)
                    PasswordTextField(showPassword: self.showPassword, password: self.$password).padding(.top,5)
                    
                    
                    
                    HStack{
                        Text("\(self.authVM.error)")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    HStack(alignment: .center){
                        Button(action: {
                            self.signUp()
                        }, label: {
                            Text("SignUp")
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
                    
                    Text("I already have an account.")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                        .padding(.top, 5)
                    Text("SignIn").foregroundColor(Color.blue).onTapGesture {
                        self.settings.selectedPage = 0
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
    func signUp(){
        let userData = RegisterUser(firstName: firstName, lastName: lastName, email: email, password: password)
        self.authVM.signUp(userData: userData)
        
        if(self.authVM.isRegistered){
            self.settings.selectedPage = 0
            self.authVM.isRegistered = false
        }
    }
}


struct SignUp_Previews: PreviewProvider {
    static let network = AuthService()
    
    static var previews: some View {
        SignUp(authVM: AuthViewModel())
    }
}








