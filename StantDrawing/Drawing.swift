//
//  Drawing.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 03/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import Foundation

public class Drawing {
    let contentDrawing: UIView
    public let drawingView: ACEDrawingView
    let drawingFrame: CGRect
    let brushColor: UIColor
    let brushToolView: BrushToolView
    
    public init(contentDrawing: UIView, brushColor: UIColor) {
        self.contentDrawing = contentDrawing
        self.drawingFrame   = contentDrawing.frame
        self.brushColor     = brushColor
        
        self.brushToolView = BrushToolView.instanceFromNib()
        
        let width  = self.drawingFrame.width - self.brushToolView.frame.width
        let height = self.drawingFrame.height
        let x      = self.drawingFrame.origin.x + self.brushToolView.frame.width
        let y      = self.drawingFrame.origin.y
        let frame = CGRect.init(x: x, y: y, width: width, height: height)
        
        self.drawingView = ACEDrawingView(frame: frame)
        
        self.brushToolView.delegate = self
        
        self.contentDrawing.addSubview(drawingView)
        self.contentDrawing.addSubview(self.brushToolView)
        
        disableUserInteractionOnDrawingView()
    }
    
    // MARK: Enable/Disable UserInteraction on DrawingView
    
    func disableUserInteractionOnDrawingView() {
        self.drawingView.isUserInteractionEnabled = false
    }
    
    func enableUserInteractionOnDrawingView() {
        self.drawingView.isUserInteractionEnabled = true
    }
    
}


// MARK: Extension for BrushToolContract protocol
extension Drawing: BrushToolContract {
    func moveCanvas(){
        self.disableUserInteractionOnDrawingView()
    }
    
    func erase(){
        self.enableUserInteractionOnDrawingView()
        self.drawingView.drawTool = ACEDrawingToolTypeEraser
    }
    
    func draw(){
        self.enableUserInteractionOnDrawingView()
        drawingView.drawTool  = ACEDrawingToolTypePen
        drawingView.lineWidth = 10.0
        drawingView.lineAlpha = 0.5
        drawingView.lineColor = brushColor
        
//        zoomView?.shouldStopDragAndScroll(false)
    }
    
    func undo(){
        self.disableUserInteractionOnDrawingView()
        self.drawingView.undoLatestStep()
    }
    
    func redo(){
        self.disableUserInteractionOnDrawingView()
        self.drawingView.redoLatestStep()
    }
    
    func save(){
        self.drawingView.removeFromSuperview()
    }
    
    func cancel(){
        self.drawingView.removeFromSuperview()
    }
}
