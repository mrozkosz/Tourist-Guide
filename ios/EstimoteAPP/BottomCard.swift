//
//  RoundedCorners.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct BottomCard: View {
    
    @State var opacity : Double = 1
    @State var height : CGFloat = 100
    @State var floating = false
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                Rectangle()
                    .frame(width: 40, height:5)
                    .cornerRadius(3)
                    .opacity(0.1)
                HStack() {
                    Text("Wyniki wyszukiwania")
                        .font(.system(size: 22))
                        .bold()
                    Spacer()
                }
                
                HStack() {
                    Text("znaleziono  pozycje")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                VStack{
                    
                    Text("wfwe")
                    //                List(beacons.nearbyContent){ i in
                    //                    Text(i.title)
                    //                }
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
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
                                
                                self.height = geo.size.height - 60
                                self.opacity = 1
                                self.floating = true
                                
                            }
                            else{
                                
                                if self.height < geo.size.height - 150{
                                    
                                    self.height = 100
                                    self.opacity = 1
                                    self.floating = false
                                }
                                else{
                                    
                                    self.height = geo.size.height - 60
                                    self.opacity = 1
                                }
                            }
                        }))
        }
    }
}
