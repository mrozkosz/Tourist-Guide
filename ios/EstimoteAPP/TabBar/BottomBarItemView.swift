//
//  BottomBarItemView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 05/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

public struct BottomBarItemView: View {
    var isSelected: Bool
    @State var item: BottomBarItem
    
    
    public var body: some View {
        HStack {
            Image(systemName: item.icon)
                .resizable()
                .frame(width:20, height:20)
                .imageScale(.large)
                .foregroundColor(isSelected ? item.color : .primary)
        }
        .padding(12)
        .background(
            Capsule()
                .fill(isSelected ?
                    item.color.opacity(0.2) : Color.clear))
            .padding(.bottom, 3)
    }
}

struct BottomBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarItemView(isSelected:true, item: BottomBarItem(icon: "search", color: .orange))
    }
}
