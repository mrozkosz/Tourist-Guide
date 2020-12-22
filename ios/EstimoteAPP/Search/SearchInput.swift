//
//  SearchView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 06/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct SearchInput: View {
    @Binding var editing:Bool
    @Binding var value:String
    var body: some View {
        
        VStack{
        TextField("Szukaj...", text:self.$value)
                .padding(15)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 10, y: 10)
                .overlay(
                    HStack {
                        Image("search")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                            .padding(.leading, 8)
                        
                        if self.editing {
                            Button(action: {
                                self.value = ""
                                self.editing = false
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .frame(width:20, height: 20)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 15) }
                        }
                    }
            )
                .onTapGesture {
                    self.editing = true
            }.padding()
            Spacer()
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#if DEBUG
struct SearchInput_Previews: PreviewProvider {
    static var previews: some View {
        SearchInput(editing:.constant(true), value: .constant("xxxxxx"))
    }
}
#endif

