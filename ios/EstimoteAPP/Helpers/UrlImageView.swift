//
//  UrlImageView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 05/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    static var defaultImage = UIImage(named: "default")
    
    init(urlString: String?) {
        imageLoader = ImageLoader(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? UrlImageView.defaultImage!)
          .resizable()
    }
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(urlString: nil)
    }
}

