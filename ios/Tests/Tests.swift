//
//  Tests.swift
//  Tests
//
//  Created by Mateusz on 19/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {

    private var app:XCUIApplication!
    
    override func setUp(){
        super.setUp()
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    func login() {
        
        let emailField = self.app.textFields["emailField"]
        emailField.tap()
        emailField.typeText("admin@wp.pl")
        
        let passwordField = self.app.secureTextFields["passwordField2"]
        passwordField.tap()
        passwordField.typeText("qwerty")
        
        let loginButton = self.app.buttons["loginButton"]
        loginButton.tap()
        
        
        let errorMessage = self.app.staticTexts["errorMessage"]
        
      XCTAssertNotNil(errorMessage)
    }

   

    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
