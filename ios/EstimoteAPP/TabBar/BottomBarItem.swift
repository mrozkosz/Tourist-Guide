//
//  BottomBarItem.swift
//  EstimoteAPP
//
//  Created by Mateusz on 05/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//


import SwiftUI

public struct BottomBarItem {
    public let icon: String
    public let title: String
    public let color: Color
    
    public init(icon: String,
                title: String,
                color: Color) {
        self.icon = icon
        self.title = title
        self.color = color
    }
}