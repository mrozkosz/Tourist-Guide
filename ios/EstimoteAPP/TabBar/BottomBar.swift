//
//  BottomBar.swift
//  EstimoteAPP
//
//  Created by Mateusz on 27/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct BottomBar : View {
    @Binding var selectedIndex:Int
    @State var items:[BottomBarItem]
    @EnvironmentObject var settings: UserSettings
  

    var body: some View {

        HStack(alignment: .bottom) {
            ForEach(0..<items.count) { index in
                
                Button(action: {
                    self.settings.isOpened = false
                     self.selectedIndex = index
                }) {
                    
                    BottomBarItemView(isSelected: self.selectedIndex == index, item: items[index])
                }

                if index != self.items.count-1 {
                    Spacer()
                }
            }
        }
        .animation(.default)
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar(selectedIndex: .constant(1), items: [BottomBarItem(icon: "search", title: "Ulubione", color: .purple)])
    }
}
