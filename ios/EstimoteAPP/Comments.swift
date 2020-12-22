//
//  Comments.swift
//  EstimoteAPP
//
//  Created by Mateusz on 21/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import SwiftUI

struct Comments:View {
    @State private var storage = LocalStorage()
    @ObservedObject var socket = SocketService()
    @Binding var id:Int
    @State var text:String = ""
    
    var body: some View {
        VStack{
            List(){
                ForEach(socket.messages, id:\.id){x in
                    
                    if(storage.email != x.user.email){
                        HStack {
                            VStack(alignment: .leading, spacing: 6){
                                Text("\(x.user.firstName) \(x.user.lastName)")
                                    .multilineTextAlignment(.center)
                                    .font(.subheadline)
                                Text("\(x.message)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                            }
                        }.padding(15)
                        .background(Color(red: 153/255, green: 153/255, blue: 1.0, opacity: 0.2))
                        .cornerRadius(20)
                        
                    }else{
                        HStack {
                            Spacer()
                            HStack() {
                                VStack(alignment: .trailing, spacing: 6){
                                    Text("Ty")
                                        .multilineTextAlignment(.center)
                                        .font(.subheadline)
                                    Text("\(x.message)")
                                        .font(.callout)
                                        .foregroundColor(.black)
                                    
                                }
                            }.padding(15)
                            .background(Color(red: 10/255, green: 153/255, blue: 1.0, opacity: 0.2))
                            .cornerRadius(20)
                        }
                    }
                }
            }
            Spacer()
            HStack{
                TextField("Napisz swoją opinię...",
                          text: $text).padding([.top,.bottom],10)
                    .autocapitalization(.none)
                    .padding(.leading,5)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .padding(.horizontal, 5)
                    .overlay(
                        Image(systemName: "arrow.up").foregroundColor(.white)
                    )
                    .onTapGesture {
                        self.socket.sendMsg(msg: self.text)
                        self.text = ""
                    }
            }.overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray,lineWidth: 0.9)
            ).padding(5)
            .navigationBarTitle("Opinie i Komentarze")
        }.onAppear{
            self.socket.connect(id: self.id)
        }
    }
}

#if DEBUG
struct Comments_Previews: PreviewProvider {
    static var previews: some View {
        Comments( id: .constant(1))
    }
}
#endif
