//
//  FullScreenCard.swift
//  EstimoteAPP
//
//  Created by Mateusz on 08/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {
    @State var categorie:Category
    @ObservedObject var categoryVM = CategoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var isOpened = UserSettings.init().isOpened
    
    var body: some View {
       
        
            VStack{
                List(self.categoryVM.categoryModel, id:\.id){ data in
                    ScrollView {
                        HStack{
                            NavigationLink(destination: SinglePleace(id: data.id)) {
                                UrlImageView(urlString: data.daily.coverImage)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:50, height: 50)
                                    .cornerRadius(10)
                                Text(data.daily.name!)
                            }
                        }
                    }
                }
            }.onAppear{
                self.categoryVM.getMethod(id: categorie.id!)
            }
            .navigationBarTitle(categorie.name!)
        
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categorie: Category(id: 1, name: "ddddd"))
    }
}
