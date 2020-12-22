//
//  ImageCarouselView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 08/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct ImageCarouselView: View {
    @Binding var galleryIsVisible: Bool
    @State var numberOfImages: Int
    @State var images: [[PhotosObjectModel]]
    @State var currentIndex: Int = 0
    @State var x:CGFloat = 0
    @State var y:CGFloat = 50
    
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Image("close")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.top,150)
                        .padding(.trailing,16)
                        .onTapGesture {
                            self.galleryIsVisible = false
                        }
                }
                Spacer()
            }.background(Color.black)
            .opacity(0.95)
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    
                    ForEach(0..<self.images.count, id:\.self){ index in
                        ForEach(self.images[index]){ image in
                            UrlImageView(urlString: image.url)
                                .aspectRatio(contentMode: .fill)
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                            
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: self.x, y: self.y)
                .animation(.spring())
                .gesture(DragGesture()
                            
                            .onChanged({ (value) in
                                
                                if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                                    self.x += value.translation.width / 15
                                }else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30{
                                    self.x -= value.translation.width / 15
                                }
                                
                            })
                            
                            .onEnded({ (value) in
                                
                                if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                                    
                                    if(self.numberOfImages > self.currentIndex+1){
                                        self.currentIndex += 1
                                    }
                                    
                                }
                                else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                                    
                                    if(self.currentIndex-1 != -1){
                                        self.currentIndex -= 1
                                    }
                                }
                                
                                self.x = CGFloat(self.currentIndex) * -geometry.size.width
                            }))
                
            }.frame(height: 300, alignment: .center)
        }
    }
}

