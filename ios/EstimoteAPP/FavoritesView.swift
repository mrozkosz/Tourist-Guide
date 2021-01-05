//
//  FavoritesView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 03/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var favoritesVM = FavoritesViewModel()
    @ObservedObject var beaconsVM = BeaconsViewModel.shared
    
    var body: some View {
        NavigationView {
            
            ZStack{
                ScrollView{
                    ForEach(self.favoritesVM.favoritesModel, id:\.id){ data in
                        
                        HStack{
                            NavigationLink(destination: SinglePleace(id: data.pleace.id!)) {
                                UrlImageView(urlString: data.pleace.coverImage!)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:50, height: 50)
                                    .cornerRadius(10)
                                Text(data.pleace.name!)
                            }
                            Spacer()
                        }.padding()
                        
                    }.onAppear{
                        self.favoritesVM.getMethod()
                    }
                }.navigationBarTitle("My Favorite Places")
                ConnectionStatus()
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
