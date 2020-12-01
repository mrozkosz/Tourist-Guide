//
//  CategoryCard.swift
//  EstimoteAPP
//
//  Created by Mateusz on 06/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct CategoryCard: View {
    @State var categorie:Category
    
    var body: some View {
        
        NavigationLink(destination: CategoriesView(categorie: self.categorie)) {
            ZStack{
                Rectangle()
                    .fill(Color("light_violet"))
                    .frame(width: 150, height: 60)
                    .cornerRadius(15)
                Text("\(self.categorie.name!)")
                    .bold()
                    .foregroundColor(Color.white)
            }
        }.buttonStyle(PlainButtonStyle())
    }
    
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(categorie: Category(id: 1, name: "Rozrywka"))
    }
}
