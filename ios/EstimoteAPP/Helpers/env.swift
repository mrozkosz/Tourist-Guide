//
//  env.swift
//  EstimoteAPP
//
//  Created by Mateusz on 17/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import UIKit
import Foundation


var baseUrl     = "http://77.55.214.2:8080"
// Applicaiton Shared Secret Key
var appSecretKey = "api-key=qt2ggwWhoc559LcNCbKd4SI40tvbRiaS"
var appApiKey = "98b027a2-fd56-41c5-ad13-9c4e01a1e317"

// Userdefaults
var userdefaults = UserDefaults.standard
var imageName = "Default.png"


// Navigation Title Name
var listViewName = "Top Stories"
var detailViewName = "Top Stories Detail"

// Application API Request
var applicationJosn = "application/json"
var acceptType = "Accept"

struct Constants {
    
    static let apiUrl = "https://api.nytimes.com/svc/"
    static let versionApi = "topstories/v2/science.json?"
    
}

class CellName {
    static let articleTableviewCell = "ArticleTableviewCell"
}
