//
//  SinglePleace.swift
//  EstimoteAPP
//
//  Created by Mateusz on 09/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct SinglePleace: View {
    @ObservedObject var pleacesVM = PleacesViewModel()
    @ObservedObject var favoritesVM = FavoritesViewModel()
    @State var galleryIsVisible:Bool = false
    @State var id:Int

    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var body: some View {
        
        ActivityIndicator(dataIsLoaded: .constant(pleacesVM.dataIsLoaded)){
            ZStack{
                GeometryReader { geometry in
                    MainImage(width: geometry.size.width, data: self.pleacesVM.singlePleaceModel)
                    ScrollView{
                        VStack(alignment: .leading){
                            
                            HStack() {
                                Text(self.pleacesVM.singlePleaceModel?.name ?? "Name").padding()
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                                Spacer()
                                
                                Button(action: {
                                    self.favoritesVM.updateMethod(id: self.id)
                                }){
                                    
                                    Image(self.favoritesVM.favorite==1 ? "heart3":"heart1")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color(red: 236/255, green: 234/255, blue: 235/255), lineWidth: 4)
                                        )
                                        .background(Color(red: 236/255, green: 234/255, blue: 235/255))
                                        .cornerRadius(30)
                                        .padding([.leading, .trailing], 20)
                                    
                                }.shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255), radius: 15, x: 0, y: 0)
                                
                            }
                            
                            Text(self.pleacesVM.singlePleaceModel?.description ?? "Description").padding()
                                .foregroundColor(Color.gray)
                            
                            Group{
                                HStack() {
                                    Text("Galeria zdjęć")
                                        .font(.headline)
                                        .padding()
                                    Spacer()
                                }
                                
                                ForEach(0..<self.pleacesVM.photos.count, id:\.self){ index in
                                    HStack{
                                        
                                        ForEach(self.pleacesVM.photos[index]){ image in
                                            UrlImageView(urlString: image.url)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight:100, maxHeight:200)
                                                .clipped()
                                                .onTapGesture{
                                                    self.galleryIsVisible = true
                                                }
                                        }
                                    }
                                    
                                }.padding(.horizontal, 10)
                            }
                            
                            
                            HStack() {
                                Text("Mapa")
                                    .font(.headline)
                                    .padding()
                                Spacer()
                            }
                            
                            
                            
                            Map(lat: 50.0, long: 19.0)
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: geometry.size.width, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(30)
                                .padding(.bottom, 300)
                            
                            
                        }.frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        .background(Color("MainColor"))
                        .cornerRadius(25)
                        .offset(y:250)
                    }
                }
                
                
                AudioPlayer(tracks: self.$pleacesVM.tracks)
                
                if(self.galleryIsVisible){
                    ImageCarouselView(galleryIsVisible: self.$galleryIsVisible, numberOfImages: self.pleacesVM.photosCount, images: self.pleacesVM.photos)
                }
                
            }.edgesIgnoringSafeArea(.all)
            
        }
        .onAppear{
            self.pleacesVM.getDataById(id: self.id)
            self.favoritesVM.getMethodByid(id: self.id)
        }
    }
    
}




struct SinglePleace_Previews: PreviewProvider {
    static var previews: some View {
        SinglePleace(id: 1)
    }
}



