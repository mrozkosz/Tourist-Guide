//
//  FavoriteButton.swift
//  EstimoteAPP
//
//  Created by Mateusz on 30/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    var body: some View {
        Button(action: {}){
            Image("heart1")
                .resizable()
                .frame(width: 20, height: 20)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 236/255, green: 234/255, blue: 235/255), lineWidth: 4)
                )
                .background(Color(red: 236/255, green: 234/255, blue: 235/255))
                .cornerRadius(25)
                .padding([.leading, .trailing], 10)
        }.shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255), radius: 10, x: 0, y: 0)
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton()
    }
}
