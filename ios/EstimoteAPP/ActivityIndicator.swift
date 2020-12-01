//
//  ActivityIndicator.swift
//  EstimoteAPP
//
//  Created by Mateusz on 06/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct ActivityIndicator<Content>: View where Content: View {
    @Binding var dataIsLoaded:Bool
    var content: () -> Content
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    var height:CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    var body: some View {
        if(self.dataIsLoaded){
            self.content()
        }else{
            ZStack(alignment: .center) {
                Spinner(isAnimating: !self.dataIsLoaded, style:.large )
                
            }
        }
        
    }
}

struct Spinner: UIViewRepresentable {
    let isAnimating: Bool
    let style:UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}


struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(dataIsLoaded: .constant(false)){
            Text("Test page")
        }
    }
}
