//
//  SinglePleace.swift
//  EstimoteAPP
//
//  Created by Mateusz on 09/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
//import ImageViewerRemote

struct SinglePleace: View {
    @ObservedObject var pleacesVM: PleacesViewModel
    
    
    var id:Int
    
    init(id:Int) {
        self.pleacesVM = PleacesViewModel()
        self.id = id
    }
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack {
            
                    ScrollView{
                        MainImage(width: geometry.size.width, data: self.pleacesVM.singlePleaceModel)
                        Group {
                            HStack() {
                                Text(self.pleacesVM.singlePleaceModel?.name ?? "Name").padding()
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                Spacer()
                                FavoriteButton()
                            }
                        }
                        
                        Text(self.pleacesVM.singlePleaceModel?.description ?? "Description").padding()
                        
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
                                            .scaledToFit()
                                            .onTapGesture {
                                                
                                            }
                                    }
                                    
                                }
                                
                            }.padding(.horizontal, 10)
                        }
                        
                    }
                    
                }
                AudioPlayer(tracks: self.$pleacesVM.tracks)
             
                
            }.edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
        }
        .onAppear{
            self.pleacesVM.getDataById(id: self.id)
        
        }
    }
    
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


struct SinglePleace_Previews: PreviewProvider {
    static var previews: some View {
        SinglePleace(id: 1)
    }
}



