//
//  HomePage.swift
//  Estimote
//
//  Created by Mateusz on 25/05/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    @State var posts:[Post] = []
    @ObservedObject var Api = API()
    @ObservedObject var loader = ImageLoader(urlString: "https://via.placeholder.com/150/d32776")
    static var defaultImage = UIImage(named: "radar_blue")
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onAppear(
                    perform: Api.get
            )
            UrlImageView(urlString: "https://via.placeholder.com/150/54176f")
                .scaledToFit()
                .frame(width: 200, height: 200)
            
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
