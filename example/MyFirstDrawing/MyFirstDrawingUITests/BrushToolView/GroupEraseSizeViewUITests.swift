//
//  GroupEraseSizeViewUITests.swift
//  MyFirstDrawingUITests
//
//  Created by Stant Macmini n04 on 09/07/19.
//  Copyright © 2019 Stant 02. All rights reserved.
//

import XCTest
import StantDrawing
@testable import MyFirstDrawing

class GroupEraseSizeViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        
        app.launch()
        
        let buttonErase = app.buttons["eraserfullIdentifier"]
        buttonErase.tap()
    }
    
    func testClickOnGroupEraseSizeViewAndShowAllButtons() {
        let eraseSizeReference = app.images.matching(identifier: "eraserfullSizeReferenceIdentifier")
        
        let buttonEraseSize1 = app.buttons["eraserSize1Identifier"]
        let buttonEraseSize2 = app.buttons["eraserSize2Identifier"]
        let buttonEraseSize3 = app.buttons["eraserSize3Identifier"]
        let buttonEraseSize4 = app.buttons["eraserSize4Identifier"]
        let buttonEraseSize5 = app.buttons["eraserSize5Identifier"]
        let buttonEraseSize6 = app.buttons["eraserSize6Identifier"]
        
        let buttons = [buttonEraseSize1, buttonEraseSize2, buttonEraseSize3, buttonEraseSize4, buttonEraseSize5, buttonEraseSize6]
        
        XCTAssertTrue(eraseSizeReference.count == 1)
        buttons.forEach { button in XCTAssertTrue(button.exists) }
    }
}
