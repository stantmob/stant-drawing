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
        
        let buttonPencil = app.buttons["pencilIdentifier"]
        buttonPencil.tap()
    }

    func testClickOnGroupPencilSizeViewAndShowAllButtons() {
        let pencilSizeReference = app.images.matching(identifier: "pencilSizeReferenceIdentifier")
        
        let buttonPencilSize1 = app.buttons["pencilSize1Identifier"]
        let buttonPencilSize2 = app.buttons["pencilSize2Identifier"]
        let buttonPencilSize3 = app.buttons["pencilSize3Identifier"]
        let buttonPencilSize4 = app.buttons["pencilSize4Identifier"]
        let buttonPencilSize5 = app.buttons["pencilSize5Identifier"]
        let buttonPencilSize6 = app.buttons["pencilSize6Identifier"]
        
        let buttons = [buttonPencilSize1, buttonPencilSize2, buttonPencilSize3, buttonPencilSize4, buttonPencilSize5, buttonPencilSize6]
        
        XCTAssertTrue(pencilSizeReference.count == 1)
        buttons.forEach { button in XCTAssertTrue(button.exists) }
    }
}
