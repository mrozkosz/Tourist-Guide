//
//  Tests.swift
//  Tests
//
//  Created by Mateusz on 19/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import XCTest

class Tests: XCTestCase {

    private var app:XCUIApplication!
    
    override func setUp(){
        super.setUp()
        self.app = XCUIApplication()
        self.app.launch()
    }


    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
