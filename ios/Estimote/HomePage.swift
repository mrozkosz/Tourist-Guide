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
    @ObservedObject var loader = ImageLoader(urlString: "http://192.168.1.213:3001/images/s480/8ZYqS6tgcYFp7fs.png")
    static var defaultImage = UIImage(named: "radar_blue")
    var audio = AudioLoader(urlString: "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3")
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
          
            UrlImageView(urlString: "http://192.168.1.213:3001/images/s1440/8ZYqS6tgcYFp7fs.png")
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
