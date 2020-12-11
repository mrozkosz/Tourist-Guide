//
//  MostVisitedCard.swift
//  EstimoteAPP
//
//  Created by Mateusz on 06/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct MostVisitedCard: View {
    @State var mostVisited:HomePagePleaceDetails?
    @Binding var fullSize:Bool
    
    
    var width: CGFloat {
        let size = self.fullSize ? 0.95:0.8
        return UIScreen.main.bounds.width * CGFloat(size)
    }
    
    var body: some View {

        NavigationLink(destination: SinglePleace(id: self.mostVisited?.id ?? 1 )) {
            UrlImageView(urlString: self.mostVisited?.coverImage)
                .frame(width:width, height: 200)
                .border(Color.gray.opacity(0.5), width: 0.5)
                .cornerRadius(15)
                .overlay(nameOverlay(name: mostVisited?.name ?? "name", location:mostVisited?.location ?? "location"))
                .overlay(arrow())
               
        }
    }
    
}

struct nameOverlay: View {
    @State var show = false
    let name: String
    let location:String
    let colors: [Color] = [Color.gray.opacity(0.8), Color.gray.opacity(0)]
    
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors),
                       startPoint: .bottomLeading, endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            Rectangle().fill(gradient).cornerRadius(15)
            
            VStack{
                HStack{
                    Image("marker")
                        .resizable()
                        .frame(width:15, height:15)
                    
                    Text(location).font(.headline).bold()
                        .frame( maxWidth: 150, maxHeight: 20, alignment: .topLeading)
                    
                }.padding(.leading,10)
                Text(name)
                    .font(.footnote).bold()
                    .frame( maxWidth: 150, alignment: .topLeading)
                    .lineLimit(1).padding(.bottom,10).padding(.leading,-5)
            }
            .foregroundColor(.white)
        }
    }
}

struct arrow: View {
    let colors: [Color] = [Color.gray.opacity(0.4), Color.gray.opacity(0)]
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors),
                       startPoint: .bottomTrailing, endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            Rectangle().fill(gradient).cornerRadius(15)
            Image("arrow").padding()
        }
        .foregroundColor(.white)
    }
}


struct MostVisitedCard_Previews: PreviewProvider {
    static var previews: some View {
        MostVisitedCard(mostVisited: HomePagePleaceDetails(id: 1, coverImage: "RGq0aLUVqP4boCk.jpeg", location: "location", name: "xxx"), fullSize: .constant(true))
    }
}
