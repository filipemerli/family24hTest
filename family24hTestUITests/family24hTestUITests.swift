//
//  family24hTestUITests.swift
//  family24hTestUITests
//
//  Created by Filipe Merli on 22/03/2019.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import XCTest

class family24hTestUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func testBasicsNavigation() {
        
        app.launch()
        let usersTableView = app.tables.matching(identifier: "usersTableView")
        let cell = usersTableView.cells.element(matching: .cell, identifier: "userCell_0")
        cell.tap()
    }

}
