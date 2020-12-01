//
//  ArticleViewModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 25/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ArticlesViewModel: ObservableObject {
    
    // Mark - Artice View Model ObsevebleObject
    let didChange = PassthroughSubject<Void, Never>()
    @Published var articleModel = [ArticelObjectModel]() {
        didSet { didChange.send() }
    }
    init()
    {
        // Mark - Webservice load funcation
        loadArticles()
    }
    private func loadArticles() {
        Webservice().getAllArticles{ article in
            DispatchQueue.main.async {
                // Mark - getter and setter call for ArticelObjectModel
                self.articleModel = article.map(ArticelObjectModel.init)
            }
        }
    }
}

// Mark - ArticelObjectModel data parsing
struct ArticelObjectModel {
    var article: ArticleDataModel
    init(article: ArticleDataModel)
    {
        self.article = article
    }
    var byline: String {
        
        return "Owner \(self.article.byline!)"
    }
    var created_date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssHHZ"
        let date  = formatter.date(from:self.article.created_date! as String)
        return "Created by - \(date!)"
    }
    
    var section: String {
        return self.article.section!
    }
    
    var title: String {
        return self.article.title!
    }
    
    var abstract: String {
        return self.article.abstract!
    }
    
    var imageURL: String {
        return (self.article.multimedia?.first?.url)!
    }
    
    var iconImage: String {
        return  self.article.multimedia?.first?.url! ?? ""
    }
    var bgImage: String {
        return  self.article.multimedia?.last?.url! ?? ""
    }
}

