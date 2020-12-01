//
//  Settings.swift
//  EstimoteAPP
//
//  Created by Mateusz on 21/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var isLogged = false
    @Published var isOpened = false
}
