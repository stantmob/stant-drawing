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
        
        let btnErase = app.buttons["eraserfullIdentifier"]
        btnErase.tap()
    }
    
    override func tearDown() {}
    
    func testClickOnGroupEraseSizeViewAndShowAllButtons() {
        let eraseSizeReference = app.images.matching(identifier: "eraserfullReferenceIdentifier")
        
        let btnEraseSize1 = app.buttons["eraserSize1Identifier"]
        let btnEraseSize2 = app.buttons["eraserSize2Identifier"]
        let btnEraseSize3 = app.buttons["eraserSize3Identifier"]
        let btnEraseSize4 = app.buttons["eraserSize4Identifier"]
        let btnEraseSize5 = app.buttons["eraserSize5Identifier"]
        let btnEraseSize6 = app.buttons["eraserSize6Identifier"]
        
        let btns = [btnEraseSize1, btnEraseSize2, btnEraseSize3, btnEraseSize4, btnEraseSize5, btnEraseSize6]
        
        XCTAssertTrue(eraseSizeReference.count == 1)
        btns.forEach { btn in XCTAssertTrue(btn.exists) }
    }
}
