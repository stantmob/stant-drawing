//
//  GroupPencilSizeViewUITests.swift
//  MyFirstDrawingUITests
//
//  Created by Stant Macmini n04 on 08/07/19.
//  Copyright © 2019 Stant 02. All rights reserved.
//

import XCTest
import StantDrawing
@testable import MyFirstDrawing

class GroupPencilSizeViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false

        app.launch()
        
        let btnPencil = app.buttons["pencilIdentifier"]
        btnPencil.tap()
    }

    func testClickOnGroupPencilSizeViewAndShowAllButtons() {
        let pencilSizeReference = app.images.matching(identifier: "pencilSizeReferenceIdentifier")
        
        let btnPencilSize1 = app.buttons["pencilSize1Identifier"]
        let btnPencilSize2 = app.buttons["pencilSize2Identifier"]
        let btnPencilSize3 = app.buttons["pencilSize3Identifier"]
        let btnPencilSize4 = app.buttons["pencilSize4Identifier"]
        let btnPencilSize5 = app.buttons["pencilSize5Identifier"]
        let btnPencilSize6 = app.buttons["pencilSize6Identifier"]
        
        let btns = [btnPencilSize1, btnPencilSize2, btnPencilSize3, btnPencilSize4, btnPencilSize5, btnPencilSize6]
        
        XCTAssertTrue(pencilSizeReference.count == 1)
        btns.forEach { btn in XCTAssertTrue(btn.exists) }
    }
}
