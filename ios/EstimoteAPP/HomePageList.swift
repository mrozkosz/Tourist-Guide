//
//  HomePageList.swift
//  EstimoteAPP
//
//  Created by Mateusz on 04/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct HomePageList: View {
    @State var showModal:Bool = true
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        NavigationView {
            
            List(){
                
                if #available(iOS 14.0, *) {
                    LazyVStack{
                        GroupOfComponents()
                    }
                } else {
                    
                    GroupOfComponents()
                }
                
            }.navigationBarHidden(true)
            
        }.navigationBarTitle("Strona Główna")
        
        
    }
}

struct GroupOfComponents: View {
    @ObservedObject var homePageVM = HomePageViewModel()
    @State var showModal:Bool = true
    
    var body: some View {
        
        Group {
            
            MainPleaceCard(pleace: self.homePageVM.dailyModel)
            
            VStack(alignment: .leading){
                Text("Najczęściej odwiedzane")
                    .font(.headline)
                    .padding(.top,16)
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10){
                        ForEach(self.homePageVM.mostVisitedModel){ mv in
                            MostVisitedCard(mostVisited:mv)
                        }
                    }.padding(.leading, 10)
                }.frame(height:200)
            }
            
            VStack(alignment: .leading){
                Text("Kategorie")
                    .font(.headline)
                    .padding(.top,16)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10){
                        ForEach(self.homePageVM.categorieModel){ categorie in
                            CategoryCard(categorie:categorie)
                        }
                    }.padding(.leading, 10)
                }.frame(height:60)
                
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
