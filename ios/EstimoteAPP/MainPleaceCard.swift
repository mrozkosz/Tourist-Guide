//
//  MainPleaceCard.swift
//  EstimoteAPP
//
//  Created by Mateusz on 06/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct MainPleaceCard: View {
    var pleace:HomePagePleaceDetails?
    
    var width: CGFloat {
        return UIScreen.main.bounds.width - 30
    }
    
    var body: some View {
        VStack{
          
            UrlImageView(urlString: self.pleace?.coverImage ?? "null" )
                .aspectRatio(contentMode: .fill)
                .frame(width:width, height: 300)
                .cornerRadius(10)
                .overlay(
                    VStack{
                        HStack {
                            Image("marker")
                                .resizable()
                                .frame(width:20, height:20)
                            Text(self.pleace?.location ?? "location" )
                                .font(.headline)
                                .foregroundColor(.white)
                        }

                    }
                )
        }.frame(height:287)
        
    }
}

#if DEBUG
struct MainPleaceCard_Previews: PreviewProvider {
    static var previews: some View {
        MainPleaceCard(pleace: HomePagePleaceDetails(id: 1, coverImage: "RGq0aLUVqP4boCk2.jpg", location: "location", name: "null"))
    }
}
#endif
