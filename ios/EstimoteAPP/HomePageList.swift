//
//  HomePageList.swift
//  EstimoteAPP
//
//  Created by Mateusz on 04/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct HomePageList: View {
    
    @ObservedObject var homePageVM = HomePageViewModel()
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        NavigationView {
            
            ZStack{
                ActivityIndicator(dataIsLoaded: .constant(homePageVM.dataIsLoaded)){
                    ScrollView(){
                        GroupOfComponents(homePageVM:homePageVM)
                    }
                }
                BottomCard()
                ConnectionStatus()
            }.navigationBarHidden(true)
        }
    }
}


struct GroupOfComponents: View {
    @ObservedObject var homePageVM:HomePageViewModel
    
    var body: some View {
        
        Group {
            
            MainPleaceCard(pleace: self.homePageVM.dailyModel)
            
            VStack(alignment: .leading){
                Text("Najczęściej odwiedzane")
                    .font(.headline)
                    .padding([.leading,.top],16)
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10){
                        ForEach(self.homePageVM.mostVisitedModel){ mv in
                            MostVisitedCard(mostVisited:mv, fullSize: .constant(false))
                        }
                    }.padding(.leading, 10)
                }.frame(height:200)
            }
            
            VStack(alignment: .leading){
                Text("Kategorie")
                    .font(.headline)
                    .padding([.leading,.top],16)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10){
                        ForEach(self.homePageVM.categorieModel){ categorie in
                            CategoryCard(categorie:categorie)
                        }
                    }.padding(.leading, 10)
                }.frame(height:60)
                
            }
            
            
            VStack(alignment: .leading){
                ForEach(self.homePageVM.restPleaces){ rp in
                    MostVisitedCard(mostVisited:rp, fullSize: .constant(true)).padding(.top,5)
                }
            }
            
            
        }
    }
}


#if DEBUG
struct HomePageList_Previews: PreviewProvider {
    static var previews: some View {
        HomePageList()
    }
}
#endif
