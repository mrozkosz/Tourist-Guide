//
//  RoundedCorners.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct BottomCard: View {
    @ObservedObject var beaconsVM = BeaconsViewModel.shared
    @State var opacity : Double = 1
    @State var height : CGFloat = 200
    @State var floating = false
    
    
    var body: some View {
        if(beaconsVM.isVisible()){
            GeometryReader{ geo in
                VStack{
                    Rectangle()
                        .frame(width: 40, height:5)
                        .cornerRadius(3)
                        .opacity(0.1)
                    HStack() {
                        Text("In your neighbourhood")
                            .font(.system(size: 22))
                            .bold()
                        Spacer()
                    }
                    
                    HStack() {
                        Text("Items found")
                            .font(.callout)
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                    
                    VStack{
                        
                        ForEach(0..<self.beaconsVM.beaconsModel.count, id:\.self){ index in
                            HStack{
                                
                                ForEach(self.beaconsVM.beaconsModel[index], id:\.id){ data in
                                    
                                    NavigationLink(destination: SinglePleace(id: data.id)) {
                                        
                                        VStack{
                                            UrlImageView(urlString: data.coverImage)
                                                .cornerRadius(20)
                                                .aspectRatio(contentMode: .fill)
                                                .scaledToFit()
                                            
                                            HStack {
                                                Text(data.location)
                                                    .font(.title)
                                                Spacer()
                                            }.padding(.leading,16)
                                            
                                            HStack {
                                                Text(data.name)
                                                    .font(.subheadline)
                                                Spacer()
                                            }.padding(.leading,16)
                                            
                                            
                                        }.padding(5)
                                    }
                                }
                                
                            }
                            
                        }.padding(.horizontal, 10)
                        
                    }
                    Spacer()
                }
                .padding()
                .background(Color("MainColor"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y: self.height)
                .animation(.spring())
                .gesture(DragGesture()
                            
                            .onChanged({ (value) in
                                
                                if self.height >= 0{
                                    
                                    self.height += value.translation.height / 8
                                    self.opacity = 0.5
                                }
                                
                            })
                            .onEnded({ (value) in
                                
                                if self.height > 100 && !self.floating{
                                    
                                    self.height = geo.size.height - 25
                                    self.opacity = 1
                                    self.floating = true
                                    
                                }
                                else{
                                    
                                    if self.height < geo.size.height - 150{
                                        
                                        self.height = 200
                                        self.opacity = 1
                                        self.floating = false
                                    }
                                    else{
                                        
                                        self.height = geo.size.height - 25
                                        self.opacity = 1
                                    }
                                }
                            }))
            }
        }
    }
}

struct BottomCard_Previews: PreviewProvider {
    static var previews: some View {
        BottomCard()
    }
}
