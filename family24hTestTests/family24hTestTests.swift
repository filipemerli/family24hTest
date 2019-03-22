//
//  family24hTestTests.swift
//  family24hTestTests
//
//  Created by Filipe Merli on 22/03/2019.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import XCTest
@testable import family24hTest

class family24hTestTests: XCTestCase {

    func testImageResize() {
        let image = #imageLiteral(resourceName: "balao")
        let responseFromResize = image.resize()
        XCTAssertNotNil(responseFromResize)
    }
    

}
