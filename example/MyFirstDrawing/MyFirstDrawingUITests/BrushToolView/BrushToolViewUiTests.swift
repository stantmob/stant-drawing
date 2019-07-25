//
//  BrushToolViewUiTest.swift
//  MyFirstDrawingUITests
//
//  Created by Stant Macmini n04 on 24/07/19.
//  Copyright © 2019 Stant 02. All rights reserved.
//

import XCTest
import StantDrawing
@testable import MyFirstDrawing

class BrushToolViewUiTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        
        app.launch()
        
     
    }
    
    func testGroupSizeViewAndEraseSizeViewToggleVisible() {
        let buttonMove   = app.buttons["moveIdentifier"]
        let buttonPencil = app.buttons["pencilIdentifier"]
        let buttonErase  = app.buttons["eraserfullIdentifier"]
        let selectColor  = app.buttons["selectColorIdentifier"]
        
        let groupPencilSizeView     = app.otherElements["groupPencilSizeView"]
        let groupEraseSizeView      = app.otherElements["groupEraseSizeView"]
        let groupSelectHexColorView = app.otherElements["groupSelectHexColorView"]
        let selectColorExpandButton = app.buttons["expandButton"]
        
        buttonPencil.tap()
        
        XCTAssertFalse(groupEraseSizeView.exists)
        XCTAssertFalse(groupSelectHexColorView.exists)
        XCTAssertTrue(groupPencilSizeView.exists)
        
        buttonErase.tap()
        
        XCTAssertFalse(groupPencilSizeView.exists)
        XCTAssertFalse(groupSelectHexColorView.exists)
        XCTAssertTrue(groupEraseSizeView.exists)
        
        selectColor.tap()

        XCTAssertFalse(groupPencilSizeView.exists)
        XCTAssertFalse(groupEraseSizeView.exists)
        XCTAssertTrue(groupSelectHexColorView.exists)
        XCTAssertTrue(selectColorExpandButton.exists)
        
        buttonPencil.tap()
        
        XCTAssertFalse(groupEraseSizeView.exists)
        XCTAssertFalse(groupSelectHexColorView.exists)
        XCTAssertTrue(groupPencilSizeView.exists)
        
        buttonMove.tap()
        
        XCTAssertFalse(groupEraseSizeView.exists)
        XCTAssertFalse(groupSelectHexColorView.exists)
        XCTAssertFalse(groupPencilSizeView.exists)
    }
}

