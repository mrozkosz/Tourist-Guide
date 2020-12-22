//
//  MainImage.swift
//  EstimoteAPP
//
//  Created by Mateusz on 30/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct MainImage: View {
    @State var width: CGFloat
    var data:SinglePleaceDataModel?
    
    var body: some View {
        Group {
     
            UrlImageView(urlString: self.data?.coverImage ?? "coverImage")
                .aspectRatio(contentMode: .fill)
                .frame(width:width, height: 300)
//                .cornerRadius(35)
                .overlay(
                    VStack{
                        HStack {
                            Image("marker")
                                .resizable()
                                .frame(width:20, height:20)
                            Text(self.data?.location ?? "location")
                                .foregroundColor(.white)
                        }
                        
                    }
                ).frame(height:300)
        }
    }
}

