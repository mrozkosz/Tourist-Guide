//
//  CategoryViewModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 26/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class CategoryViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    @Published var categoryModel = [CategoryObjectModel]() {
        didSet { didChange.send() }
    }
    
    public func getMethod(id:Int) {
        CategoryService().getDataById(id: id){ article in
            DispatchQueue.main.async {
                self.categoryModel = article.map(CategoryObjectModel.init)
            }
        }
    }
}

struct CategoryObjectModel {
    
    var category: CategoryDataModel
    init(category: CategoryDataModel){
        self.category = category
    }
    
    var id: Int {
        return self.category.id!
    }
    
    var daily: Pleace {
        return self.category.pleace!
    }
    
}

